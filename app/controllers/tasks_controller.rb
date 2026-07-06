class TasksController < ApplicationController
  layout "workspace"
  before_action :require_login
  before_action :set_project, only: [ :index, :new, :create ]
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  
  before_action :require_manager, only: [ :new, :create ]
  before_action :require_admin, only: [ :destroy ]
  before_action :authorize_task_access, only: [ :show, :edit, :update ]

  def index
    if @project
      @tasks = @project.tasks
    else
      @tasks = Task.all
    end

    if current_user.employee?
      @tasks = @tasks.where(user_id: current_user.id)
    end

    if params[:search].present?
      @tasks = @tasks.where("title ILIKE ? OR description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:filter].present?
      case params[:filter]
      when "pending"
        @tasks = @tasks.pending
      when "completed"
        @tasks = @tasks.completed
      when "overdue"
        @tasks = @tasks.overdue
      when "high_priority"
        @tasks = @tasks.high_priority
      end
    end

    if params[:sort].present?
      case params[:sort]
      when "latest"
        @tasks = @tasks.order(created_at: :desc)
      when "oldest"
        @tasks = @tasks.order(created_at: :asc)
      when "due_date"
        @tasks = @tasks.order(due_date: :asc)
      when "priority"
        @tasks = @tasks.order(priority: :desc)
      end
    else
      @tasks = @tasks.order(created_at: :desc)
    end

    @tasks = @tasks.paginate(page: params[:page], per_page: 10) if @tasks.respond_to?(:paginate)
  end

  def show
  end

  def new
    @task = @project.tasks.build
  end

  def create
    @task = @project.tasks.build(task_params)
    if @task.save
      flash[:notice] = "Task created successfully."
      redirect_to project_tasks_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    permitted_params = current_user.employee? ? employee_task_params : task_params

    if @task.update(permitted_params)
      flash[:notice] = "Task updated successfully."
      redirect_to @task
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "Task deleted successfully."
    redirect_to tasks_path, status: :see_other
  end

  private

  def set_project
    @project = Project.find(params[:project_id]) if params[:project_id].present?
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :priority, :status, :due_date, :user_id)
  end

  def employee_task_params
    params.require(:task).permit(:status)
  end

  def authorize_task_access
    if current_user.employee? && @task.user_id != current_user.id
      flash[:alert] = "Access denied. You can only access your assigned tasks."
      redirect_to dashboard_path
    end
  end
end

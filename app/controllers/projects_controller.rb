class ProjectsController < ApplicationController
  layout "workspace"
  before_action :require_login
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  before_action :require_manager, except: [ :index, :show ]
  before_action :require_admin, only: [ :destroy ]

  def index
    @projects = Project.all

    if params[:search].present?
      @projects = @projects.where("title ILIKE ? OR description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:filter].present?
      case params[:filter]
      when "active"
        @projects = @projects.active
      when "completed"
        @projects = @projects.completed
      when "overdue"
        @projects = @projects.overdue
      end
    end

    if params[:sort].present?
      case params[:sort]
      when "latest"
        @projects = @projects.latest
      when "deadline"
        @projects = @projects.order(deadline: :asc)
      end
    else
      @projects = @projects.latest
    end

    @projects = @projects.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project created successfully."
      redirect_to @project
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project updated successfully."
      redirect_to @project
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project deleted successfully."
    redirect_to projects_path, status: :see_other
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :deadline, :status)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end

class DashboardsController < ApplicationController
  before_action :require_login
  layout "workspace"

  def index
    @total_users = User.active_count
    @active_projects = Project.active.count
    @open_tasks = Task.where.not(status: "completed").count
    @overdue_tasks = Task.overdue.count
    
    @recent_projects = Project.latest.limit(4)
    @my_tasks = current_user.tasks.where.not(status: "completed").order(due_date: :asc).limit(5)
  end
end

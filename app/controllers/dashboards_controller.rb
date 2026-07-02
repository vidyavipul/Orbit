class DashboardsController < ApplicationController
  before_action :require_login
  layout "workspace"

  def index
  end
end

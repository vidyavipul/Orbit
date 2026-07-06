module AuthorizationConcern
  extend ActiveSupport::Concern

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Access denied."
      redirect_to dashboard_path
    end
  end

  def require_manager
    unless current_user && (current_user.admin? || current_user.manager?)
      flash[:alert] = "Access denied."
      redirect_to dashboard_path
    end
  end

  def authorize_user
    unless @user == current_user || (current_user && current_user.admin?)
      flash[:alert] = "You can only edit your own profile."
      redirect_to dashboard_path
    end
  end
end

module AuthorizationConcern
  extend ActiveSupport::Concern

  def authorize_user
    unless @user == current_user || (current_user && current_user.admin?)
      flash[:alert] = "You can only edit your own profile."
      redirect_to dashboard_path
    end
  end
end

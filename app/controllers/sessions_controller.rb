class SessionsController < ApplicationController
  def new
  end

  def create
    login_id = params[:session][:login_identifier].to_s.downcase
    @user = User.find_by(email: login_id) || User.find_by(username: login_id)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the world of Orbit"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid Login Credentials"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out successfully"
    redirect_to root_path
  end

  # Handles GET /logout
  def logout_via_get
    if logged_in?
      session[:user_id] = nil
      flash[:notice] = "You have been logged out successfully"
      redirect_to root_path
    else
      redirect_to login_path
    end
  end
end

class UsersController < ApplicationController
  before_action :require_login, except: [ :new, :create ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user, only: [ :edit, :update, :destroy ]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the world of Orbit, you have been successfully signed up"
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  def show
  end
  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile Updated"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    @user.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def user_params
    if current_user && current_user.admin? && @user != current_user
      # Admins editing other users can ONLY change role and active status
      params.require(:user).permit(:role, :active)
    else
      # Users editing their own profile can change their details
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end

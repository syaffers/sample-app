class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @papers = @user.papers
    @reviews = @user.reviews
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      # go to user page
      sign_in @user
      flash[:success] = "Welcome to TransPub!"
      redirect_to @user
    else 
      # Go back to form again
      render 'new'
    end
  end
  
  def edit
    # old implementation: @user = User.find(params[:id])
  end
  
  def update
    # old implementation: @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def update_status
    if @user.update_attributes(status_params)
      flash[:success] = "User updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def status_params
      params.require(:user).permit(:admin, :editor)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless ( current_user?(@user) || is_admin? )
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def is_admin?
      current_user.admin?
    end
end

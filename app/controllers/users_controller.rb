class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :destroy, :edit]
  before_action :admin_user, only: [:destroy]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to tasks_path
    end
  end 

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    elsif
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザを更新しました。"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      render "show"
    else
      redirect_to tasks_path
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

 

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end

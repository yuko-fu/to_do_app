class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :destroy, :edit]
  before_action :authenticate_admin!
  
  def index
    @users = User.select(:id, :name)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザを作成しました。"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザを削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def authenticate_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "管理者権限が必要です。"
    end
  end
end
class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.select(:id, :name, :admin)
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
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
      redirect_to admin_users_path, notice: 'ユーザーが更新されました。'
    else
      flash.now[:alert] = 'ユーザーの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーが削除されました。'
    else
      flash[:alert] = 'ユーザーの削除に失敗しました。'
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,:password, :password_confirmation, :admin)
  end

  def authenticate_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "管理者権限が必要です。"
    end
  end
end
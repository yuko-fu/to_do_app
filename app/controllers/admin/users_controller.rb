class Admin::UsersController < ApplicationController

  def index
    @users = User.select(:id, :name)
  end


  private

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, notice: "管理者以外はアクセスできません"
    end
  end
end
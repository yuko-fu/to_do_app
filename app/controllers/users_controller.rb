class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :destroy]
  


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    elsif
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      render "show"
    else
      redirect_to  new_session_path
    end

    def destroy
      User.find(params[:id]).destroy
      redirect_to admin_users_path, notice:"ユーザー削除しました"
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

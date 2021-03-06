class Admin::UsersController < ApplicationController
  before_action :prohibit_user_access
  def index
    @users = User.all.includes(:tasks)
  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def destroy
    @user = User.find(params[:id]).destroy
    flash[:notice] = "ユーザを削除しました！"
    redirect_to admin_users_path
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def prohibit_user_access
    unless current_user.admin
      redirect_to tasks_path
    end
  end

end

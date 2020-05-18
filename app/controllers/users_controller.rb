class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create, :update]
  before_action :prohibit_signup, only: :new
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      @user.labels.build(title: "safe", color: "青", shape: "四角").save
      @user.labels.build(title: "danger", color: "赤", shape: "矢印").save
      flash[:notice] = "ユーザ登録しました！"
      if logged_in?
        redirect_to admin_users_path
      else
        session[:user_id] = @user.id
        redirect_to user_path(@user.id)
      end
    else
      if logged_in?
        render 'admin/users/new'
      else
        render :new
      end
    end
  end
  def show
    @user = User.find(params[:id])
    prohibit_other_profiles
  end
  def update
    if logged_in? && current_user.admin
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "ユーザ情報を更新しました！"
        redirect_to admin_user_path
      else
        render 'admin/users/edit'
      end
    else
      redirect_to tasks_path
    end
  end
  def destroy
    @user = User.find(params[:id]).destroy
    flash[:notice] = "ユーザを削除しました！"
    redirect_to admin_users_path
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
  def prohibit_other_profiles
    if current_user.id != @user.id
      redirect_to tasks_path
    end
  end
  def prohibit_signup
    if logged_in?
      redirect_to user_path(current_user.id)
    end
  end
end

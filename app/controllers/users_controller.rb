class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザ登録しました！"
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
    prohibit_other_profiles
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def prohibit_other_profiles
    if current_user.id != @user.id
      redirect_to tasks_path
    end
  end
end

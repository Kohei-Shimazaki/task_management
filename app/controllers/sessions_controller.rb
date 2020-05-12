class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  before_action :avoid_new_action, only: :new
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました！"
      redirect_to user_path(user.id)
    else
      flash[:deanger] = "ログインに失敗しました！"
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました！"
    redirect_to new_session_path
  end
  private
  def avoid_new_action
    if logged_in?
      redirect_to user_path(current_user.id)
    end
  end
end

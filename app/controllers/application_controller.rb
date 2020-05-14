class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :authenticate_user
  private
  def authenticate_user
    unless logged_in?
      flash[:notice] = "ログインはこの画面からお願いします。"
      redirect_to new_session_path
    end
  end
end

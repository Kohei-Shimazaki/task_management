class ApplicationController < ActionController::Base
  protect_from forgery with: :exception
  include SessionsHelper
end

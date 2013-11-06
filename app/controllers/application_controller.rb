class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin_user!
    sign_out current_user unless dj?
    redirect_to "/admin/login" unless dj?
  end

  def dj?
    current_user && current_user.role?("dj")
  end
end

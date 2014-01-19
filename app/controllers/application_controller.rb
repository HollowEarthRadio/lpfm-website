class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin_user!
    unless current_user && current_user.dj?
      sign_out current_user
      redirect_to "/admin/login"
    end
  end
end

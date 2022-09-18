class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #helper_method :current_user, :logged_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  #def current_user
  #  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #end
  #def logged_in?
  #  !!current_user
  #end
  #def require_user
  #  unless logged_in?
  #    flash[:danger] = "You must be logged in to perform that action"
  #    redirect_to root_path
  #  end
  #end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email)
    end
  end
end

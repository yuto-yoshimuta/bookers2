class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    flash[:success] = "Signed in successfully."
    user_path(resource.id)
  end


  def after_sign_out_path_for(resource)
    flash[:success] = "Signed out successfully."
    root_path
  end

  def after_sign_up_path_for(resource)
    flash[:success] = "Welcome! You have signed up successfully."
    user_path(resource)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end
end

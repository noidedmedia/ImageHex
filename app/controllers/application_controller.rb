class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  protected
  def ensure_user
    unless user_signed_in?
      redirect_to("/users/sign_in")
    end
  end

  # What page we are on
  def page
    params[:page]
  end
  # How many things to display per page
  def per_page
    if user_signed_in?
      # A user's set page preference...
      current_user.page_pref
    # Or the parameter page pref...
    elsif (1..100).include? params[:page]
      params[:page]
    else
      20
    end
  end

      
  def configure_devise_permitted_parameters
    registration_params = [:name, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end
end

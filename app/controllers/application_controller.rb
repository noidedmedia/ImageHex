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
    params[:page] ? params[:page] : 1
  end
  # How many things to display per page
  def per_page
    # Block is comented out until implimented properly
    # if user_signed_in?
      # A user's set page preference...
      # current_user.page_pref
    # Or the parameter page pref...
    if (1..100).include? params[:page_pref]
      params[:page_pref]
    else
      10
    end
  end

      
  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end

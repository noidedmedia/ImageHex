##
# The root application controller for Imagehex.
# Any functionality we have to access from all controllers goes here.
class ApplicationController < ActionController::Base
  # Adds different "flash[:type]" types.
  add_flash_types :warning, :info
  before_action :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized

  def unauthorized
    render 'shared/401', status: :unauthorized
  end

  protected

  ##
  # Ensure that a user is logged in.
  # If one is not, redirect to a page where they can do that.
  def ensure_user
    redirect_to("/accounts/sign_in") unless user_signed_in?
  end

  ##
  # Defines what page the user is on.
  # In the query string as params[:page].
  # If no page is set, assume we're on page 1.
  def page
    params[:page] ? params[:page] : 1
  end

  ##
  # The number of things to display on each page.
  # Works like this:
  # 1. If the user is signed in and has a preference, use that.
  # 2. If the user has added a query string specifying the page pref in
  #    "page_pref", use that if it's reasonable. We define a reasonable
  #    page_pref to be between 1 and 100.
  # 3. Use 20, the default.
  def per_page
    if user_signed_in? && current_user.page_pref
      current_user.page_pref
    elsif (1..100).cover? params["page_pref"]
      params["page_pref"]
    else
      20
    end
  end

  ##
  # Add a query string for the Locale if needed.
  def default_url_options(options = {})
    return options if I18n.locale == I18n.default_locale
    { locale: I18n.locale }.merge options
  end

  ##
  # Allow devise to add a user's name on creation.
  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :subscribed_to_newsletter
  end

  DEFAULT_CONTENT = {
    "nsfw_language" => true
  }.freeze

  def content_pref
    (params["content_filter"] || current_user.try(:content_pref) || DEFAULT_CONTENT)
  end

  ##
  # Set the locale.
  # Locales are either in the URL, or the default (English).
  # If they're in the URL, they should be in params[:locale]
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

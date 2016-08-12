#frozen_string_literal: true
##
# Controller for things related to Users.
# Uses friendly_id for ids.
class UsersController < ApplicationController
  include Pundit
  before_action :ensure_user, only: [:edit, :update, :delete, :destroy, :enable_twofactor, :disable_twofactor, :verify_twofactor]

  ##
  # Confirm that provided two-factor authentication code matches OTP key for
  # a given user.
  # @user:: The user enabling two-factor auth.
  def confirm_twofactor
    @user = User.friendly.find(params[:id])
    authorize @user
    respond_to do |format|
      if (@backup_codes = @user.confirm_twofactor(params[:otp_key]))
        UserMailer.enable_twofactor(@user).deliver_now
        format.html
        format.json { render json: @backup_codes }
      else
        format.html { redirect_to verify_twofactor_user_path(@user), warning: I18n.t("notices.incorrect_two_factor_authentication_code") }
      end
    end
  end

  ##
  # Display a QR Code for the Authentication app.
  # @user:: The user enabling two-factor auth.
  def verify_twofactor
    @user = User.friendly.find(params[:id])
    authorize @user
    respond_to do |format|
      format.gif do
        render qrcode: @user.otp_provisioning_uri(@user.email,
                                                  issuer: "ImageHex")
      end
      format.svg do
        render qrcode: @user.otp_provisioning_uri(@user.email,
                                                  issuer: "ImageHex")
      end
      format.html
    end
  end

  ##
  # Enable two-factor authentication for a given user.
  # @user:: The user enabling two-factor auth.
  def enable_twofactor
    @user = User.friendly.find(params[:id])
    authorize @user
    respond_to do |format|
      if @user.enable_twofactor
        format.html { redirect_to verify_twofactor_user_path(@user) }
      else
        format.html { redirect_to settings_path, error: @user.errors }
      end
    end
  end

  ##
  # Disable two-factor authentication for a given user.
  # @user:: The user disabling two-factor auth.
  def disable_twofactor
    @user = User.friendly.find(params[:id])
    authorize @user
    if @user.valid_password?(params[:password])
      @user.otp_required_for_login = false
      @user.two_factor_verified = false
      respond_to do |format|
        if @user.save
          UserMailer.disable_twofactor(@user).deliver_now
          format.html { redirect_to settings_path, notice: I18n.t("notices.two_factor_authentication_has_been_successfully_disabled") }
        else
          format.html { redirect_to settings_path, error: @user.errors }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to settings_path, warning: I18n.t("notices.incorrect_password") }
        format.json { render json: "invalid_password" }
      end
    end
  end

  ##
  # "Browse creators" page
  # @users:: A list of users, as chosen by the get_user_index method below.
  def index
    @users = get_user_index
      .preload(:creations)
      .merge(Image.for_content(content_pref))
      .paginate(page: page, per_page: per_page)
  end

  def search
    @users = User.all
      .search(params)
      .paginate(page: page,
                per_page: per_page)
  end


  ##
  # A collection of images favorited by a given user.
  # @user:: The user in question.
  # @collection:: The favorites collection for this user.
  # @images:: Images favorited by this user.
  def favorites
    @user = User.friendly.find(params[:id])
    @collection = @user.favorites
    @images = @collection.images
      .for_content(content_pref)
      .paginate(page: page, per_page: per_page)
    render 'collections/show'
  end

  ##
  # A collection of images credited to a given user.
  # @user:: The user in question.
  # @collection:: The creations collection for this user.
  # @images:: Images credited to this user.
  def creations
    @user = User.friendly.find(params[:id])
    @images = @user.creations
      .for_content(content_pref)
      .paginate(page: page, per_page: per_page)
    if params[:created_after] then
      t = Time.at(params[:created_after].to_f)
      @images = @images.where("images.created_at > ?", t)
    end
  end

  ##
  # Subscribe to a user.
  # @user:: User the current_user is subscribing to.
  # TODO: Pundit authenticate, should check if subscription is saved before
  # returning success?
  def subscribe
    @user = User.friendly.find(params[:id])
    current_user.subscribe! @user
    respond_to do |format|
      format.json { render json: { success: true } }
      format.html { redirect_to @user }
    end
  end

  ##
  # Unsubscribe from a user.
  # @user:: User the current_user is unsubscribing from.
  # TODO: Pundit authenticate, should check if removal of subscription is
  # saved before returning success?
  def unsubscribe
    @user = User.friendly.find(params[:id])
    current_user.unsubscribe! @user
    respond_to do |format|
      format.json { render json: { success: true } }
      format.html { redirect_to @user }
    end
  end

  ##
  # Show a user's profile, including their bio and collections.
  # User should be in params[:id]
  #
  # Sets the following variables:
  # @user:: The user we're viewing.
  # @uploads:: Images the user has uploaded.
  # @collections:: Collections the user curates.
  def show
    @user = User.friendly.find(params[:id])
    @uploads = @user.images
      .paginate(page: page, per_page: per_page)
      .for_content(content_pref)
    @creations = @user.creations
      .paginate(page: page, per_page: per_page)
      .for_content(content_pref)
    @favorites = @user.favorite_images
      .paginate(page: page, per_page: per_page)
      .for_content(content_pref)
    @collections = @user.collections
    @listings = policy_scope(@user.listings).includes(:images)
    # HACK
    @content = content_pref
  end

  ##
  # Shows a page where the user can edit their bio and various preferences.
  # Ensures that params[:id] is the current_user and requires login, for
  # obvious reasons.
  # Sets the following variables:
  # @user:: The user being edited.
  def edit
    @user = params[:id] ? User.friendly.find(params[:id]) : current_user
    authorize @user
  end

  #
  # Post to update the user in params[:id].
  # Ensures that current_user is the user in params[:id] beforehand.
  #
  # If the user cannot be updated, it puts the errors in flash[:error] and
  # redirects to the edit page again.
  # @user:: The user being updated.
  def update
    @user = User.friendly.find(params[:id])
    authorize @user
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to current_user, notice: I18n.t("notices.changes_have_been_saved") }
      else
        format.html { redirect_to edit_user_path(current_user), warning: current_user.errors.full_messages.join(",") }
      end
    end
  end

  protected

  ##
  # Convenience method that finds users for the "Browse Creators" page.
  # Sorted either by account creation date or popularity.
  def get_user_index
    case params[:order]
    when 'popular'
      User.popular_creators
    else
      User.recent_creators
    end
  end

  ##
  # Parameters to update a user.
  # page_pref:: The amount of images per page.
  # avatar:: The user's avatar image.
  # otp_required_for_login:: Two-Factor Authentication boolean.
  # description:: The user's description.
  # subscribed_to_newsletter:: User subscribed to newsletter boolean.
  # content_pref:: What types of content the user is alright with seeing.
  def user_params
    params
      .require(:user)
      .permit(:page_pref,
              :avatar,
              :otp_required_for_login,
              :description,
              :subscribed_to_newsletter,
              content_pref: [:nsfw_language,
                             :nsfw_gore,
                             :nsfw_nudity,
                             :nsfw_sexuality])
  end
end

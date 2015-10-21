##
# Controller for things related to Users.
# Uses friendly_id for ids.
class UsersController < ApplicationController
  include Pundit
  before_filter :ensure_user, only: [:edit, :update, :delete, :destroy, :enable_twofactor, :disable_twofactor]

  def twofactor_key
    @user = User.friendly.find(params[:id])
    authorize @user
    respond_to do |format|
      format.gif { render qrcode: @user.otp_provisioning_uri(@user.email,
     issuer: "ImageHex") }
      format.png { render qrcode: @user.otp_provisioning_uri(@user.email,
     issuer: "ImageHex") } 
      format.html
    end
  end

  def enable_twofactor
    puts "Enablding twofactor I hope"

    @user = User.friendly.find(params[:id])
    authorize @user
    respond_to do |format|
      if @user.enable_twofactor
        format.html { redirect_to @user }
      else
        format.html { redirect_to @user, error: @user.errors }
      end
    end
  end

  def disable_twofactor
    @user = User.friendly.find(params[:id])
    authorize @user
    @user.otp_required_for_login = false
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user }
      else
        format.html { redirect_to @user, error: @user.errors }
      end
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
    @creations = @user.creations.images
    .paginate(page: page, per_page: per_page)
    .for_content(content_pref)
    @collections = @user.collections.subjective
  end

  ##
  # Shows a page where the user can edit their bio and various preferences.
  # Ensures that params[:id] is the current_user and requires login, for
  # obvious reasons.
  # Sets the following variables:
  # @user:: The user who is being edited. 
  def edit
    @user = User.friendly.find(params[:id])
    authorize @user
    @user.user_page ||= UserPage.new
  end

  #
  # Post to update the user in params[:id].
  # Ensures that current_user is the user in params[:id] beforehand.
  # 
  # If the user cannot be updated, it puts the errors in flash[:error] and 
  # redirects to the edit page again.
  def update
    return unless current_user == User.friendly.find(params[:id])
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
  # Parameters to update a user.
  # page_pref:: The amount of images per page.
  # avatar:: The user's avatar image. 
  # user_page_attributes:: Should have a body attribute, which is the user's
  #                        Bio.
  def user_params
    params
    .require(:user)
    .permit(:page_pref,
            :avatar,
            :otp_required_for_login,
            user_page_attributes: [:body],
            content_pref: [:nsfw_language,
              :nsfw_gore,
              :nsfw_nudity,
              :nsfw_sexuality])
  end
end

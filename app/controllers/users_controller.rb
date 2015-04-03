class UsersController < ApplicationController
  before_filter :ensure_user, only: [:edit, :update, :delete, :destroy]
  ##
  # Show a user's profile, including their bio and collections.
  # User should be in params[:id]
  # 
  # Sets the following variables:
  # @user:: The user we're viewing.
  # @images:: Images the user has uploaded.
  # @collections:: Collections the user curates.
  def show
    @user = User.friendly.find(params[:id])
    @images = @user.images.paginate(page: page, per_page: per_page)
    @collections = @user.collections
  end

  ##
  # Shows a page where the user can edit their bio and various preferences.
  # Ensures that params[:id] is the current_user and requires login, for
  # obvious reasons.
  # Sets the following variables:
  # @user:: The user who is being edited. 
  def edit
    if current_user != User.friendly.find(params[:id])
      redirect_to edit_user_path(current_user) and return
    else
      @user = current_user
      @user.user_page ||= UserPage.new
    end
  end

  ##
  # Post to update the user in params[:id].
  # Ensures that current_user is the user in params[:id] beforehand.
  # 
  # If the user cannot be updated, it puts the errors in flash[:error] and 
  # redirects to the edit page again.
  def update
    return unless current_user == User.friendly.find(params[:id])
    if current_user.update(user_params)
      redirect_to current_user
    else
      flash[:error] = current_user.errors.full_messages.join(",")
      redirect_to user_edit_page(current_user)
    end
  end

  protected
  ##
  # Parameters to update a user.
  # page_pref:: The amount of images per page.
  # avatar_id:: The ID of the users's avatar. Getting refactored out at some 
  #             point in order to allow users to add avatars that aren't
  #             on ImageHex.
  # user_page_attributes:: Should have a body attribute, which is the user's
  #                        Bio.
  def user_params
    params.require(:user).permit(:page_pref,
                                 :avatar_id,
                                 user_page_attributes: [:body])
  end
end

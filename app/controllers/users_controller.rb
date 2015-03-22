class UsersController < ApplicationController
  before_filter :ensure_user, only: [:edit, :update, :delete, :destroy]
  def show
    @user = User.friendly.find(params[:id])
    @images = @user.images.paginate(page: page, per_page: per_page)
    @collections = @user.collections
  end

  def edit
    if current_user != User.friendly.find(params[:id])
      redirect_to edit_user_path(current_user) and return
    else
      @user = current_user
    end
  end

  def update
    return unless current_user == User.friendly.find(params[:id])
    if current_user.update(user_params)
      redirect_to current_user
    else
      flash[:error] = current_user.errors.full_messages.join(",")
    end
  end

  protected
  def user_params
    params.require(:user).permit(:page_body,
                                 :avatar_id,
                                 :page_pref)
  end
end

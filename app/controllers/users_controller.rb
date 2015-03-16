class UsersController < ApplicationController
  before_filter :verify_user, only: [:edit, :update, :delete, :destroy]
  def show
    @user = User.friendly.find(params[:id])
    @images = @user.images.paginate(page: page, per_page: per_page)
    @collections = @user.collections
  end

  def edit
    @user = current_user
  end

  def update

  end

  protected
  def verify_user
    if current_user then
      return true
    else
      redirect_to "/"
    end
  end
end

class UsersController < ApplicationController
  before_filter :verify_user, only: [:edit, :update, :delete, :destroy]
  def show
    @user = User.find(params[:id])
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

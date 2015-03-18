class UserPagesController < ApplicationController
  before_action :ensure_user
  def edit
    @page = current_user.user_page
    @user = current_user
  end

  def update
    p = current_user.user_page
    p.update(page_params)
    if p.save
      redirect_to current_user
    else
      flash[:errors] = p.errors.full_messages.join(", ")
      redirect_to "/page_edit"
    end

  end

  protected
  def page_params
    params.require(:user_page).permit(:body)
  end
end

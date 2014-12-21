class Admin::AdminController < ApplicationController
  before_filter :ensure_admin

  protected
  def ensure_admin
    if current_user && current_user.role == :admin
      return true
      # We're good
    else
      redirect_to("/login")
      return false
    end
  end
end

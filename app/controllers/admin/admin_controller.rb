class Admin::AdminController < ApplicationController
  before_filter :ensure_admin
  protected
  def ensure_admin
    # For some freaking reason rails stores the enum (which you create with
    # symbols) as a string.
    #
    # Why?
    #
    # Because life is sad. So you need to compare to the string "admin"
    # instead of :admin
    if current_user && current_user.role == "admin"
      return true
      # We're good
    else
      redirect_to("/users/sign_in")
      return false
    end
  end
end

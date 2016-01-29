##
# The root controller for the Admin namespace.
# Ensures only admins can access actions within.
class Admin::AdminController < ApplicationController
  before_action :ensure_admin

  protected

  ##
  # Verify that the user is an admin. Redirects to the login page if they
  # are't.
  # TODO: make this redirect to an "access denied" type page.
  # Maybe even one with the HL1 voice clip.
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
      return render 'shared/401'
    end
  end
end

##
# A namespace which exists to hold actions that only administrators can
# perform.
module Admin
end

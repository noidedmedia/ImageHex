##
# See notifications a user has. 
# This entire controller requires login, as it doesn't really make sense for
# people who aren't logged in to have notifications.
class NotificationsController < ApplicationController
  before_action :ensure_user

  ##
  # Obtain a list of all notifications for the current_user
  def index
    @notifications = current_user.notifications.order("created_at DESC")
      .limit(10)
  end

  ##
  # Mark all unread notifications as read.
  # Returns a JSON response as we always do it with AJAX.
  def mark_all_read
    render json: current_user.notifications.unread.update_all(read: true)
  end
  ##
  # Mark the notification in params[:id] as read.
  # Returns a JSON response indicating success.
  def read
    n = current_user.notifications.where(id: params[:id]).first
    raise ActiveRecord::RecordNotFound unless n
    n.read = true
    worked = n.save
    render json: (worked ? worked : notifications.errors.full_messages)
  end
  ##
  # Obtain a list of unread notifications.
  # Returns JSON or HTML.
  # Sets the following varaibles:
  # @notifications:: All unread notifications.
  def unread
    @notifications = current_user.notifications.unread
    respond_to do |format|
      format.html
      format.json { render json: @notifications}
    end
  end
end

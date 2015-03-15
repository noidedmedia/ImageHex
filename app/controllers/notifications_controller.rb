class NotificationsController < ApplicationController
  before_action :ensure_user
  def index
    @notifications = current_user.notifications
  end

  def mark_all_read
    render json: current_user.notifications.unread.update_all(read: true)
  end
  def read
    n = current_user.notifications.where(id: params[:id]).first
    n.read = true
    worked = n.save
    render json: (worked ? worked : notifications.errors.full_messages)
  end
  def unread
    @notifications = current_user.notifications.unread
    respond_to do |format|
      format.html
      format.json { render json: @notifications}
    end
  end
end

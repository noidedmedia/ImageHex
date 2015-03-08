class NotificationsController < ApplicationController
  before_action :ensure_user
  def index
    @notifications = current_user.notifications
  end

  def unread
    @notifications = current_user.notifications.unread
  end
end

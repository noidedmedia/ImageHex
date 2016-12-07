class NewNotificationJob < ApplicationJob
  queue_as :default

  def perform(notification)
    id = notification.user_id
    ActionCable.server.broadcast "notifications_#{id}",
      ApplicationController
        .renderer
        .render(partial: "notifications/stub.json.jbuilder", 
                locals: {notification: notification})
  end
end

class NotificationMailer < ApplicationMailer
  default from: "notifications@imagehex.com"
  layout "mailer"

  def notification_email(notification)
    @notification = notification
    @user = notification.user
    @subject = @notification.subject
    mail(to: @user.email, subject: notification_subject)
  end

  private

  def notification_subject
    subject = @notification.subject
    case @notification.kind
    when :uploaded_image_commented_on
      "Somebody commented on your image"
    when :subscribed_image_commented_on
      "Somebody commented on your image"
    when :comment_replied_to
      "#{subject[:user_name]} replied to your comment"
    when :mentioned
      "#{subject[:user_name]} mentioned you in a comment"
    when :new_subscriber
      "#{subject[:name]} subscribed to you!"
    when :order_confirmed
     ["#{subject[:customer_name]} placed an order",
      "for \"#{subject[:listing_name]}\""].join(" ")
    when :order_accepted
      "Your order for \"#{subject[:listing_name]}\" was accepted"
    when :order_paid
      "#{subject[:customer_name]} paid for their order"
    when :order_filled
      "#{subject[:seller_name]} filled your order"
    else
      "You recieved a notification"
    end
  end
end

# frozen_string_literal: true
##
# A notification is a way to alert the user of something, generally the action of a different user.
# Notifications which aren't read are displayed to the user when they log in.
# A typical usage is notifying a user that they have a new comment on an
# image they've uploaded, or that somebody has replied to one of their comments.
class Notification < ActiveRecord::Base
  #############
  # RELATIONS #
  #############

  belongs_to :user, touch: true

  ##########
  # SCOPES #
  ##########

  scope :unread, -> { where(read: false) }

  ###############
  # VALIDATIONS #
  ###############

  validates :user, presence: true
  validates :subject, presence: true

  # Enum for the notification type.
  # 
  # uploaded_image_commented_on:: An image the user uploaded has a new comment.
  # subscribed_image_commented_on:: An image the user is subscribed to has a
  # new comment.
  # comment_replied_to:: User comment has been replied to.
  # mentioned:: User has been mentioned in a comment.
  # new_subscriber:: User has a new subscriber.
  enum kind: [:uploaded_image_commented_on,
              :subscribed_image_commented_on,
              :comment_replied_to,
              :mentioned,
              :new_subscriber,
              :order_confirmed,
              :order_accepted,
              :order_paid,
              :order_filled,
              :order_rejected]

  after_commit :send_email, if: :should_send_email?, on: :create
  after_commit :notify_cables


  def subject=(sub)
    to_write = nil
    case sub
    when Comment
      to_write = {
        user_name: sub.user.name,
        type: :comment,
        commentable_type: sub.commentable_type,
        commentable_id: sub.commentable_id,
        id: sub.id
      }
    when User
      to_write = {
        name: sub.name,
        id: sub.id,
        type: :user
      }
    when Order
      to_write = {
        order_id: sub.id,
        listing_id: sub.listing.id,
        listing_name: sub.listing.name,
        type: :order,
        customer_id: sub.user.id,
        customer_name: sub.user.name,
        seller_id: sub.listing.user.id,
        seller_name: sub.listing.user.name
      }
    end
    self[:subject] = to_write
  end

  def should_send_email?
    user.notifications_pref[self.kind]
  end

  def send_email
    NotificationMailer.notification_email(self).deliver_later
  end

  private
  def notify_cables
    NewNotificationJob.perform_later(self)
  end

end

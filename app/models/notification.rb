##
# A notification is a way to alert the user of something, generally the action of a different user.
# Notifications which aren't read are displayed to the user when they log in.
# A typical usage is notifying a user that they have a new comment on an
# image they've uploaded, or that somebody has replied to one of their comments.
class Notification < ActiveRecord::Base
  #############
  # RELATIONS #
  #############
  belongs_to :user
  ##
  # SCOPES
  scope :unread, ->{where(read: false)}

  ###############
  # VALIDATIONS #
  ###############
  validates :user, presence: true
  validates :subject, presence: true
  enum kind: [:uploaded_image_commented_on,
    :subscribed_image_commented_on,
    :comment_replied_to,
    :mentioned,
    :new_subscriber]

  def subject=(sub)
    to_write = nil
    case sub
    when Comment
      to_write = {
        user_name: sub.user.name,
        type: :comment,
        commentable_type: sub.commentable_type,
        commentable_id: sub.commentable_id
      }
    when User
      to_write = {
        name: sub.name,
        id: sub.id,
        type: :user
      }
    end
    write_attribute(:subject, to_write)
  end
end

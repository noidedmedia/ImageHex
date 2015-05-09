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
  belongs_to :subject, polymorphic: true

  ##
  # SCOPES
  scope :unread, ->{where(read: false)}

  ###############
  # VALIDATIONS #
  ###############
  validates :user, presence: true
  validates :subject, presence: true
  validates :message, presence: true
end

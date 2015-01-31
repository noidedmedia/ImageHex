class Notification < ActiveRecord::Base
  #############
  # RELATIONS #
  #############
  belongs_to :user
  belongs_to :subject, polymorphic: true

  ###############
  # VALIDATIONS #
  ###############
  validates :user, presence: true
  validates :subject, presence: true
  validates :message, presence: true
end

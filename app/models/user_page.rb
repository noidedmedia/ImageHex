class UserPage < ActiveRecord::Base
  belongs_to :user

  ###############
  # VALIDATIONS #
  ###############
  validates :user, presence: true

end

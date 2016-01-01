class Conversation < ActiveRecord::Base
  belongs_to :commission_offer,
    required: false
  has_many :conversation_users
  has_many :users, through: :conversation_users

  def for_offer?
    !! commission_offer
  end
end

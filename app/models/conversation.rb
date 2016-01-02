class Conversation < ActiveRecord::Base
  belongs_to :commission_offer,
    required: false
  has_many :conversation_users, inverse_of: :conversation
  has_many :users, through: :conversation_users

  accepts_nested_attributes_for :conversation_users
  def for_offer?
    !! commission_offer
  end
end

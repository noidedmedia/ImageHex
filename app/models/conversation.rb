class Conversation < ActiveRecord::Base
  belongs_to :commission_offer,
             required: false
  has_many :conversation_users, inverse_of: :conversation
  has_many :users, through: :conversation_users
  has_many :messages
  accepts_nested_attributes_for :conversation_users
  def for_offer?
    !!commission_offer
  end

  class UserNotInConversation < StandardError
  end

  def mark_read!(user)
    cu = conversation_user_for(user)
    fail UserNotInConversation unless cu
    cu.touch(:last_read_at)
  end

  def messages_for_user(user)
    if cu = conversation_user_for(user)
      if timestamp = cu.last_read_at
        messages.where("created_at > ?", timestamp)
      else
        messages
      end
    else
      fail UserNotInConversation
    end
  end

  def conversation_user_for(user)
    conversation_users.where(user: user).first
  end
end

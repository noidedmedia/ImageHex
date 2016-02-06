class Conversation < ActiveRecord::Base
  belongs_to :commission_offer,
             required: false
  has_many :conversation_users, inverse_of: :conversation
  has_many :users, through: :conversation_users
  has_many :messages
  accepts_nested_attributes_for :conversation_users
  def for_offer?
    !commission_offer.nil?
  end

  class UserNotInConversation < StandardError
  end

  def mark_read!(user)
    cu = conversation_user_for(user)
    raise UserNotInConversation unless cu
    cu.touch(:last_read_at)
  end

  def messages_for_user(user)
    # rubocop:disable Lint/AssignmentInCondition
    if cu = conversation_user_for(user)
      if timestamp = cu.last_read_at
        # rubocop:enable Lint/AssignmentInCondition
        messages.where("created_at > ?", timestamp)
      else
        messages
      end
    else
      raise UserNotInConversation
    end
  end

  def conversation_user_for(user)
    conversation_users.find_by(user: user)
  end
end

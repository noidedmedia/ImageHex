class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  ##########
  # SCOPES #
  ##########
  def self.unread_for(user)
    joins("INNER JOIN conversation_users ON conversation_users.conversation_id = messages.conversation_id")
      .where(conversation_users: {user_id: user.id})
      .where("messages.created_at > conversation_users.last_read_at")
      .order("messages.conversation_id")     
  end

  def self.with_read_status_for(user)
    joins("INNER JOIN conversation_users ON conversation_users.conversation_id = messages.conversation_id")
      .where(conversation_users: {user_id: user.id})
      .select("messages.*, (messages.created_at < conversation_users.last_read_at) AS read")
  end
end

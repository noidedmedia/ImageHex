class NewMessageJob < ApplicationJob
  queue_as :default

  ALLOWED_ATTRIBUTES = %w(id body conversation_id created_at user_id)
  def perform(message)

    hash = {}
    hash[message.id] = message.attributes.keep_if do |k, v|
      ALLOWED_ATTRIBUTES.include? k
    end
    message.conversation.user_ids.each do |id|
      ActionCable.server.broadcast "chat_#{id}",
        {type: "add_messages",
          data: hash}
    end
  end
end

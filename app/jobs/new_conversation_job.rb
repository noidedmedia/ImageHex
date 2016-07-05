class NewConversationJob < ApplicationJob
  queue_as :default

  def perform(conv)
    conv.user_ids.each do |id|
      ActionCable.server.broadcast "chat_#{id}",
        {type: "refresh_conversation_list"}
    end
  end
end

# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def read(data)
    time = Time.zone.now
    cid = data['cid']
    h = {}
    ConversationUser
      .where(conversation_id: cid,
             user_id: current_user.id)
      .update_all(last_read_at: time)
    h[cid] = time
    data = {
      type: "read_conversations",
      data: h
    }
    ActionCable.server.broadcast("chat_#{current_user.id}",data)
  end

end

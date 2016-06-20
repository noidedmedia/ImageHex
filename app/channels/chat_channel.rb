# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def read(data)
    cid = data['cid']
    conv = Conversation.find(cid)
    conv.mark_read! current_user
    h = {}
    h[cid] = conv.last_read_for(current_user)
    data = {
      type: "read_conversations",
      data: h
    }
    ActionCable.server.broadcast("chat_#{current_user.id}",data)
  end

end

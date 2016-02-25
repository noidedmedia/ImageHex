json.initialUnread @messages, partial: "messages/message", as: :message
json.currentUserId current_user.id
json.initialFetched Time.zone.now

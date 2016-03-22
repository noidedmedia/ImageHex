json.extract! @conversation, :id, :name
json.messages @messages, partial: "messages/message", as: :message
json.last_read @last_read
json.users @conversation.users, partial: "users/stub", as: :user

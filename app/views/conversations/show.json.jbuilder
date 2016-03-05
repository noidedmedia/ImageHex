json.extract! @conversation, :id, :name
json.messages @conversation.messages, partial: "messages/message", as: :message
json.users @conversation.users, partial: "users/stub", as: :user

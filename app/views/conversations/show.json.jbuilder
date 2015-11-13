json.extract! @conversation, :id, :title
json.users @conversation.users, partial: "users/stub"

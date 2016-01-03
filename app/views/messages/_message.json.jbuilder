json.extract! message, :id, :body, :conversation_id, :created_at
json.user message.user, partial: "users/stub", as: :user

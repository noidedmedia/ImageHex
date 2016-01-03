json.extract! conversation, :id, :updated_at
json.users conversation.users, partial: "users/stub", as: :user

# frozen_string_literal: true
json.extract! @message, :body, :id, :conversation_id, :created_at
json.read true
json.user @message.user, partial: "users/stub", as: :user

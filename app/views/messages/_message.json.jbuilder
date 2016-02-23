# frozen_string_literal: true
json.extract! message, :id, :body, :conversation_id, :created_at, :read
json.user message.user, partial: "users/stub", as: :user

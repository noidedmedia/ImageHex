# frozen_string_literal: true
json.extract! @message, :body, :id, :conversation_id, :created_at, :user_id
json.read true

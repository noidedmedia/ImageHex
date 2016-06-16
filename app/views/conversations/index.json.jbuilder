# frozen_string_literal: true
json.conversations do
  json.partial! "conversation", collection: @conversations, as: :conversation
end

# frozen_string_literal: true
json.extract! conversation, :id, 
  :updated_at,
  :name,
  :has_unread,
  :last_read_time

json.users conversation.users, partial: "users/stub", as: :user

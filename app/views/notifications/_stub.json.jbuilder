# frozen_string_literal: true
json.extract! notification,
              :kind,
              :created_at,
              :subject,
              :read,
              :updated_at,
              :id
json.time_ago_in_words time_ago_in_words(notification.created_at)

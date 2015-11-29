json.extract! notification, :kind, :created_at, :subject, :read, :updated_at
json.time_ago_in_words time_ago_in_words(notification.created_at)

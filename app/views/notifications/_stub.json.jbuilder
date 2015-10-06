json.extract! notification, :kind, :created_at
json.subject_url polymorphic_url(notification.subject)

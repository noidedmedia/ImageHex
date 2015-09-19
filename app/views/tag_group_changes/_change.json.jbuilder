json.extract! change, :created_at, :user_id
json.before_tag_ids change.before
json.after_tag_ids change.after
json.user_url polymorphic_path(change.user, format: :json)

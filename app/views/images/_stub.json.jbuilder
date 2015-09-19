json.extract! image, :id, :description,
  :user_id,
  :created_at,
  :updated_at,
  :license,
  :medium
json.url images_url(image, format: :json)
json.medium_thumbnail image.f.url(:medium)
json.large_thumbnail image.f.url(:large)
json.nsfw_gore image.nsfw_gore
json.nsfw_language image.nsfw_language
json.nsfw_nudity image.nsfw_nudity
json.nsfw_sexuality image.nsfw_sexuality

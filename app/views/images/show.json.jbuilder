json.extract! @image,
              :id,
              :user_id,
              :created_at,
              :updated_at,
              :description,
              :license,
              :medium
json.nsfw_gore @image.nsfw_gore
json.nsfw_language @image.nsfw_language
json.nsfw_nudity @image.nsfw_nudity
json.nsfw_sexuality @image.nsfw_sexuality
json.content_type @image.f_content_type
json.file_url @image.f.url
json.creators @image.creators, partial: "users/stub", as: :user
json.tag_groups @groups do |group|
  json.tags(group.tags) do |tag|
    json.extract! tag, :name, :id
    json.url url_for(tag)
  end
  json.id group.id
end

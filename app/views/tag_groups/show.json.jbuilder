json.extract! @tag_group, :id, :image_id
json.tags(@tag_group.tags) do |tag|
  json.extract! tag, :name, :id, :display_name
  json.url url_for(tag)
end


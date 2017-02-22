json.extract! group,
  :id,
  :description,
  :created_at,
  :updated_at

json.tags group.tags do |tag|
  json.extract! tag,
    :name,
    :id,
    :description
end

json.images group.images, partial: "image", as: :image

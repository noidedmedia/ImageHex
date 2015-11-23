json.array! @creators do |c|
  json.extract! c, :name, :id, :slug, :description
  json.images c.creations.limit(5), partial: "images/stub", as: :image
end


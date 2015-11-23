json.array! @creators do |c|
  json.extract c, :name, :id, :slug, :description
end


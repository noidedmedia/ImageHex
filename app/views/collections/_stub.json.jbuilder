json.extract! collection, :name, :id, :type
json.url polymorphic_path(collection, format: :json)


json.extract! c, :name, :id, :type
json.url polymorphic_path(c, format: :json)

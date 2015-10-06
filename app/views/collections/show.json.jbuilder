json.extract! @collection, :name, :id, :type, :description
json.images do 
  json.partial! 'images/list', images: @images
end
json.curators @curators do |curator|
  json.extract! curator, :name, :id
  json.url user_url(curator, format: :json)
end

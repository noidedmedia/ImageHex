json.extract! @tag, :name, :description, :id
json.images do 
  json.partial! 'images/list', images: @images
end


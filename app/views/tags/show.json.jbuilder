json.extract! @tag, :name, :description, :id, :display_name
json.images do 
  json.partial! 'images/list', images: @images
end


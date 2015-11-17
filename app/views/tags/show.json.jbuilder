json.extract! @tag, :name, :description, :id, :display_name
if @images.blank?
  json.images []
else
  json.images do 
    json.partial! 'images/list', images: @images
  end
end


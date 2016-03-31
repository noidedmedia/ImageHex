# frozen_string_literal: true
json.extract! @tag, :name, :description, :id
if @images.blank?
  json.images []
else
  json.images do
    json.partial! 'images/list', images: @images
  end
end

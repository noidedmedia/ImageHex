# frozen_string_literal: true
json.images do
  json.partial! "images/list", images: @images
end

# frozen_string_literal: true
json.array! @users do |c|
  json.extract! c, :name, :id, :slug, :description
  json.images c.creations.take(5), partial: "images/stub", as: :image
end

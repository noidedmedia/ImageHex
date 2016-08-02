# frozen_string_literal: true
json.array! @collections do |c|
  json.extract! c, :id, :name
  json.contains_image c.contains_image unless c.try(:contains_image).nil?
end

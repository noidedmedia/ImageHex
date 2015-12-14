json.array! @collections do |c|
  json.extract! c, :id, :name, :type
  unless c.try(:contains_image).nil?
    json.contains_image c.contains_image
  end
end

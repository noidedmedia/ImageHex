json.extract! image,
  :created_at,
  :updated_at,
  :description

image.img.styles.keys.each do |k|
  json.public_send("#{k}_url", image.img.url(k))
end

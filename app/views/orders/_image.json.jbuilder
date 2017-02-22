json.extract! image,
  :created_at,
  :updated_at,
  :description,
  :id

json.small_url image.img.url(:small)
json.medium_url image.img.url(:medium)
json.large_url image.img.url(:large)
json.source_url image.img.url(:source)

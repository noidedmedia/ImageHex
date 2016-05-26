json.extract! @listing,
  :name,
  :description,
  :base_price,
  :quote_only,
  :created_at

json.options @listing.options do |option|
  json.extract! option,
    :price,
    :name,
    :description
end

json.categories @listing.categories do |category|
  json.extract! category,
    :price,
    :name,
    :description,
    :max_count,
    :free_count
end

json.images @listing.images, partial: "images/stub", as: :image

json.extract! @listing,
  :name,
  :description,
  :base_price,
  :quote_only,
  :created_at

json.options @listing.options do |option|
  json.extract! option,
    :price,
    :reference_category,
    :max_allowed,
    :name,
    :description,
    :free_count
end

json.images @listing.images, partial: "images/stub", as: :image

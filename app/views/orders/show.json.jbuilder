json.listing do
  json.extract! @listing,
    :name,
    :description,
    :base_price,
    :quote_only,
    :created_at

  json.options @listing.options do |option|
    json.extract! option,
      :id,
      :price,
      :reference_category,
      :max_allowed,
      :name,
      :description,
      :free_count
  end
end

json.extract! @order,
  :description

json.aspects @order.aspects do |aspect|
  json.extract! aspect,
    :description
end

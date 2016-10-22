json.listing do
  json.extract! @listing,
    :name,
    :description,
    :base_price,
    :quote_only,
    :created_at

  json.username @listing.user.name

  json.options @listing.options do |option|
    json.extract! option,
      :id,
      :price,
      :name,
      :description
    json.html_description markdown_parse(option.description)
  end

  json.categories @listing.categories do |category|
    json.extract! category,
      :id,
      :price,
      :name,
      :description,
      :max_count,
      :free_count

    json.html_description markdown_parse(category.description)
  end
end

json.extract! @order,
  :description,
  :name

json.references @order.references do |ref|
  json.extract! ref,
    :id,
    :listing_category_id,
    :description

  json.tags ref.tags do |tag|
    json.extract! tag,
      :name,
      :id
  end

  json.images ref.images do |img|
    json.extract! img,
      :id,
      :description
    json.url img.img(:medium)
  end
end

json.order_options @order.order_options do |opt|
  json.extract! opt,
    :id,
    :listing_option_id
end

json.listing do
  json.extract! @listing,
    :name,
    :description,
    :created_at

  json.username @listing.user.name
end

json.extract! @order,
  :description,
  :name

json.groups @order.groups, partial: "group", as: :group

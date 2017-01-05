json.extract! @listing,
  :name,
  :description,
  :created_at

json.images @listing.images, partial: "images/stub", as: :image

json.extract! @offer,
  :id,
  :created_at,
  :confirmed
json.subjects @offer.subjects, partial: "subject",
  as: :subject

json.background @offer.background,
  partial: "background",
  as: :background


json.user @offer.user, partial: "users/stub", as: :user
if @offer.commission_product
  json.product @offer.commission_product, 
    partial: "commission_products/product",
    as: :product
end

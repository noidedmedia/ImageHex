# frozen_string_literal: true
json.extract! product,
              :id,
              :name,
              :description,
              :created_at,
              :updated_at,
              :base_price,
              :included_subjects,
              :subject_price,
              :background_price,
              :offer_background,
              :offer_subjects,
              :maximum_subjects,
              :include_background
json.user product.user, partial: "users/stub", as: :user
json.example_images product.example_images.take(3) do |i|
  json.extract! i, :id, :created_at
  json.thumbnail path_to_image(i.f :medium)
end

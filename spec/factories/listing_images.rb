FactoryGirl.define do
  factory :listing_image do
    image
    listing{ create(:listing, user: image.user) }
  end
end

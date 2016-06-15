FactoryGirl.define do
  factory :listing_image, :class => 'Listing::Image' do
    image { create(:image_with_creator) }
    listing{ create(:listing, user: image.creators.sample) }
  end
end

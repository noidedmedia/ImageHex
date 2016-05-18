FactoryGirl.define do
  factory :listing_category, :class => 'Listing::Category' do
    listing
    price 500
    max_count 10
    free_count 0
  end
end

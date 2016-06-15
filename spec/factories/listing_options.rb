FactoryGirl.define do
  factory :listing_option, :class => 'Listing::Option' do
    listing 
    price 100
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
  end
end

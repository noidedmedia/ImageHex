FactoryGirl.define do
  factory :aspect do
    order { create(:order, listing: create(:listing)) }
    option { order.listing.options.sample } 
    description { Faker::Lorem.paragraph } 
  end
end

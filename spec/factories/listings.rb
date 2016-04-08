FactoryGirl.define do
  factory :listing do
    user
    base_price 1000
    description { Faker::Lorem.paragraph }
    name { Faker::Commerce.product_name }
    quote_only false
    factory :quote_listing do
      base_price nil
      quote_only true
    end
  end
end

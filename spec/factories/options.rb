FactoryGirl.define do
  factory :option do
    listing 
    price 100
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
  end
end

FactoryGirl.define do
  factory :option do
    listing 
    price 100
    reference_category false
    max_allowed 1
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    factory :reference_option do
      reference_category true
      max_allowed 100
    end
  end
end

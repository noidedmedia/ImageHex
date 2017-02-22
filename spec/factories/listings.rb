FactoryGirl.define do
  factory :listing do
    user
    description { Faker::Lorem.paragraph }
    name { Faker::Commerce.product_name }
    open false

    factory :open_listing do
      open true
    end
  end
end

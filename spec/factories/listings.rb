FactoryGirl.define do
  factory :listing do
    user
    description { Faker::Lorem.paragraph }
    name { Faker::Commerce.product_name }
    confirmed true

    factory :unconfirmed_listing do
      confirmed false
    end

    factory :open_listing do
      open true
    end
  end
end

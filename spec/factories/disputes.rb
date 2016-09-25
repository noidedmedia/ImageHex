FactoryGirl.define do
  factory :dispute do
    description { Faker::Lorem.paragraph }
    order
  end
end

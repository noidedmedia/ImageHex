FactoryGirl.define do
  factory :order do
    listing
    user
    description { Faker::Lorem.paragraph } 
  end
end

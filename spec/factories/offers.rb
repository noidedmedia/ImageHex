FactoryGirl.define do
  factory :offer do
    listing
    user
    description { Faker::Lorem.paragraph } 
  end
end

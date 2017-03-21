FactoryGirl.define do
  factory :note do
    user 
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph } 
  end
end

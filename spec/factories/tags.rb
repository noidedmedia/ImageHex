FactoryGirl.define do
  factory :tag do
    name { Faker::Name.name }
  end
end

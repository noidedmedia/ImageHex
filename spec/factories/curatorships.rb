FactoryGirl.define do
  factory :curatorship do
    user
    collection
    level :admin
  end
end

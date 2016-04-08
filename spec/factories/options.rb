FactoryGirl.define do
  factory :option do
    listing nil
    price 1
    reference_category false
    max_allowed 1
    name "MyString"
    description "MyText"
  end
end

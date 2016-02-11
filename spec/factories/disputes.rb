FactoryGirl.define do
  factory :dispute do
    commission_offer
    description "MyText"
    resolved false
  end
end

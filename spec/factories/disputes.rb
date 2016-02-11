FactoryGirl.define do
  factory :dispute do
    user nil
    commission_offer nil
    commission_product nil
    description "MyText"
    resolved false
  end
end

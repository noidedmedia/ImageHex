FactoryGirl.define do
  factory :commission_product do
    user
    name "Sketch"
    description "EZ Product, EZ Life"
    base_price 500
    subject_price 500
  end

end

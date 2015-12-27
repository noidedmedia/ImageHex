FactoryGirl.define do
  factory :commission_product do
    user
    name "Sketch"
    description "EZ Product, EZ Life"
    base_price 500
    subject_price 500
    offer_background true
    background_price 100
    weeks_to_completion 4
  end

end

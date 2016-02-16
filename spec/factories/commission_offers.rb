# frozen_string_literal: true
FactoryGirl.define do
  factory :commission_offer do
    commission_product
    user
    total_price 1
    description "MyText"
  end
end

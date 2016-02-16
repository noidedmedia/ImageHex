# frozen_string_literal: true
FactoryGirl.define do
  factory :commission_image do
    image
    commission_offer
  end
end

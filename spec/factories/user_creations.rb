# frozen_string_literal: true
FactoryGirl.define do
  factory :user_creation do
    user
    creation { FactoryGirl.create(:image) }
  end
end

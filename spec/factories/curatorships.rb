# frozen_string_literal: true
FactoryGirl.define do
  factory :curatorship do
    user
    collection
    level :admin
  end
end

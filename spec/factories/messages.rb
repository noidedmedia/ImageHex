# frozen_string_literal: true
FactoryGirl.define do
  factory :message do
    user
    conversation
  end
end

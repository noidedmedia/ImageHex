# frozen_string_literal: true
FactoryGirl.define do
  factory :conversation_user do
    user
    conversation
  end
end

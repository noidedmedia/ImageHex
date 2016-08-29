# frozen_string_literal: true
FactoryGirl.define do
  factory :message do
    conversation { create(:conversation, include_users: true)}
    user { conversation.users.sample } 
  end
end

# frozen_string_literal: true
FactoryGirl.define do
  factory :artist_subscription do
    user
    artist { FactoryGirl.create(:user) }
  end
end

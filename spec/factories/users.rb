# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    name { Faker::Internet.user_name(nil, %w(_)) }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
    after(:build) do |user|
      user.skip_confirmation!
    end
  end
end

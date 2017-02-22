# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| Faker::Internet.user_name(nil, %w(_)) + n.to_s }
    sequence(:email) {|n| "#{name}#{n}@example.com" }
    password { Faker::Internet.password(8) }
    after(:build) do |user|
      user.skip_confirmation!
    end

    after(:create) do |user|
      user.confirm
    end
  end
end

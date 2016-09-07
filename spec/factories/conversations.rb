# frozen_string_literal: true
FactoryGirl.define do
  factory :conversation do
    transient do
      include_users { true }
    end

    name { Faker::Lorem.word }
    after(:build) do |c, i|
      if i.include_users
        u = create(:user)
        a = create(:user)
        a.subscribed_artists << u
        u.subscribed_artists << a
        c.users = [u, a]
      end
    end
  end
end

# frozen_string_literal: true
FactoryGirl.define do
  factory :conversation_user do
    user
    conversation { create(:conversation, include_users: true) } 

    after(:build) do |c|
      collect = c.conversation.users.where.not(id: c.user.id)
      c.user.subscribed_artists << collect
      collect.each do |u|
        u.subscribed_artists << c.user
      end
    end
  end


end

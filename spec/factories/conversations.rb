require 'pry'
FactoryGirl.define do
  factory :conversation do
    user_ids { FactoryGirl.create_list(:user, 2).map(&:id) }
  end
end

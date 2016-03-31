# frozen_string_literal: true
FactoryGirl.define do
  factory :tag_group_member do
    tag
    tag_group
  end
end

# frozen_string_literal: true
FactoryGirl.define do
  factory :tag_group do |_f|
    image
    after(:build) do |tg|
      tg.tag_ids = [FactoryGirl.create(:tag).id]
    end
  end
end

# frozen_string_literal: true
FactoryGirl.define do
  factory :commission_subject_tag do
    tag
    commission_subject
  end
end

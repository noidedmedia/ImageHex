# frozen_string_literal: true
FactoryGirl.define do
  factory :collection do
    curators { [FactoryGirl.create(:user)] }
    name "Test"
  end

  factory :subjective, parent: :collection, class: "Subjective" do
  end
end

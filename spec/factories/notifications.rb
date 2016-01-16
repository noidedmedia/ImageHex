FactoryGirl.define do
  factory :notification do
    user
    subject { FactoryGirl.build(:comment) }
    read false
  end
end

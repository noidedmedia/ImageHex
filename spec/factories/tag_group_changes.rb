FactoryGirl.define do
  factory :tag_group_change do
    tag_group 
    user 
    kind 1
    before { [FactoryGirl.create(:tag)] }
    after { [FactoryGirl.create(:tag)] }
  end

end

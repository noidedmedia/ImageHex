FactoryGirl.define do
  factory :collection do
    users {[FactoryGirl.create(:user)]}
    name "Test"
  end


  factory :subjective, parent: :collection, class: "Subjective" do

  end
end

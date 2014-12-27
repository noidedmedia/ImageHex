FactoryGirl.define do
  factory :collection do
    user
    name "Test"
  end

  factory :favorite, parent: :collection, class: "Favorite" do

  end

  factory :creation, parent: :collection, class: "Creation" do

  end

  factory :subjective, parent: :collection, class: "Subjective" do

  end
end

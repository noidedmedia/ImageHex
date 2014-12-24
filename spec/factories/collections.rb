FactoryGirl.define do
  factory :collection do
    user
  end

  factory :favorites, parent: :collection, class: "Favorite" do

  end

  factory :created, parent: :collection, class: "Created" do

  end

  factory :subjective, parent: :collection, class: "Subjective" do

  end
end

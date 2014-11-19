FactoryGirl.define do
  factory :tag_group do |f|
    image
    after(:build) do |tg|
      tg.tags << FactoryGirl.create(:tag)
    end
  end
end

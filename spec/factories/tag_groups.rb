FactoryGirl.define do
  factory :tag_group do |f|
    image
    after(:build) do |tg|
      tg.tag_ids = [FactoryGirl.create(:tag).id]
    end
  end
end

FactoryGirl.define do
  factory :tag_topic, class: 'Tag::Topic' do
    tag 
    user
    title { Faker::Lorem.sentence }
  end
end

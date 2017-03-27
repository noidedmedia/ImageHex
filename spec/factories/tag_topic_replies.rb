FactoryGirl.define do
  factory :tag_topic_reply, class: 'Tag::Topic::Reply' do
    association :topic, factory: :tag_topic
    user 
    body { Faker::Lorem.paragraph } 
  end
end

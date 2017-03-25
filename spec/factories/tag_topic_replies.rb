FactoryGirl.define do
  factory :tag_topic_reply, class: 'Tag::Topic::Reply' do
    topic nil
    user nil
    body "MyText"
  end
end

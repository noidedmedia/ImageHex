FactoryGirl.define do
  factory :tag_topic, class: 'Tag::Topic' do
    tag nil
    user nil
    title "MyText"
  end
end

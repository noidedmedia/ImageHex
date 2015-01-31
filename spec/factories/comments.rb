FactoryGirl.define do
  factory :comment do
    body "MyText"
    commentable {FactoryGirl.build(:image)}
    user
  end

end

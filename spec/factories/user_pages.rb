FactoryGirl.define do
  factory :user_page do
    markdown "MyString"
    compiled "MyString"
    user
    elsewhere {}
  end

end

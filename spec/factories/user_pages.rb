FactoryGirl.define do
  factory :user_page do
    body "yo"
    user
    elsewhere Hash.new
  end

end

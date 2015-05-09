FactoryGirl.define do
  factory :user do
   name { Faker::Internet.user_name, "_"}
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }

  end

end

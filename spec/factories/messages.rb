FactoryGirl.define do
  factory :message do
    conversation 
    user { conversation.users[0] } 
  end

end

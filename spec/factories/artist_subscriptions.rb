FactoryGirl.define do
  factory :artist_subscription do
    user
    artist { FactoryGirl.create(:user) }    
  end

end

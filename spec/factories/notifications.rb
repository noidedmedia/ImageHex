FactoryGirl.define do
  factory :notification do
    user 
    subject {FactoryGirl.build(:comment)}
    message "We did some things, yay!"
    read false
  end

end

FactoryGirl.define do
  factory :report do
    severity :illegal
    message "MyString"
    reportable :image
  end

end

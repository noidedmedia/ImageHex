FactoryGirl.define do
  factory :report do
    user
    severity :illegal
    message "MyString"
    after(:create) do |r|
      r.reportable = FactoryGirl.create(:image) unless r.reportable
    end
  end

end

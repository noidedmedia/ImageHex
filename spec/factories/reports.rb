FactoryGirl.define do
  factory :report do
    severity :illegal
    message { (0..6).to_a.map{|x| Faker::Name.name}.join("")}
    reportable { FactoryGirl.build(:image) }
  end

end

FactoryGirl.define do
  factory :commission_offer do
    commission_product nil
    user nil
    total_price 1
    description "MyText"
    charged_date "2015-12-14 13:11:20"
  end

end

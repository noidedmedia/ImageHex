FactoryGirl.define do
  factory :conversation do

    factory :commission_conversation do
      commission_offer
    end   
  end

end

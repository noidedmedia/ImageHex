FactoryGirl.define do
  factory :order do
    listing
    user
    description { Faker::Lorem.paragraph } 

    transient do 
      reference_count 2
    end

    after(:build) do |o, e|
      o.references = build_list(:order_reference,
                                e.reference_count,
                                order: o)
    end
  end
end

FactoryGirl.define do
  factory :order do
    listing
    user
    description { Faker::Lorem.paragraph } 

    transient do 
      reference_group_count 2
    end

    after(:build) do |o, e|
      o.reference_groups = build_list(:order_reference_group,
                                      e.reference_count,
                                      order: o)
    end
  end
end

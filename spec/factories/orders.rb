FactoryGirl.define do
  factory :order do
    listing
    user
    description { Faker::Lorem.paragraph } 

    transient do 
      group_count 2
    end

    after(:build) do |o, e|
      o.groups = build_list(:order_group,
                            e.group_count,
                            order: o)
    end
  end
end

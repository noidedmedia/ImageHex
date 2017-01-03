FactoryGirl.define do
  factory :order_reference_group, :class => 'Order::ReferenceGroup' do
    order
    description { Faker::Lorem.paragraph } 
  end
end

FactoryGirl.define do
  factory :order_group, :class => 'Order::Group' do
    order
    description { Faker::Lorem.paragraph } 
  end
end

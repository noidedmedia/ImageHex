FactoryGirl.define do
  factory :order_reference, :class => 'Order::Reference' do
    order 
    category { order.listing.categories.sample }
    description "MyText"
  end
end

FactoryGirl.define do
  factory :order_option, :class => 'Order::Option' do
    order 
    option { order.listing.options.sample }
  end
end

FactoryGirl.define do
  factory :order_reference_tag, class: 'Order::Reference::Tag' do
    order_reference
    tag
  end
end

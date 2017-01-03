FactoryGirl.define do
  factory :order_reference_group_tag, class: 'Order::Reference::Tag' do
    order_reference
    tag
  end
end

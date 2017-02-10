FactoryGirl.define do
  factory :order_group_tag, class: 'Order::Group::Tag' do
    reference_group { create(:order_group) }
    tag
  end
end

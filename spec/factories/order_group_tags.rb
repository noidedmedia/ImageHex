FactoryGirl.define do
  factory :order_group_tag, class: 'Order::Group::Tag' do
    group { create(:order_group) }
    tag
  end
end

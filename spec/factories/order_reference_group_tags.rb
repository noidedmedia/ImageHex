FactoryGirl.define do
  factory :order_reference_group_tag, class: 'Order::ReferenceGroup::Tag' do
    reference_group { create(:order_reference_group) }
    tag
  end
end

class Order::ReferenceGroup::Tag < ActiveRecord::Base
  belongs_to :reference_group,
    class_name: "Order::ReferenceGroup",
    foreign_key: :order_reference_group_id,
    inverse_of: :reference_tags

  belongs_to :tag
end

class Order::Group::Tag < ActiveRecord::Base
  belongs_to :group,
    class_name: "Order::Group",
    foreign_key: :order_group_id,
    inverse_of: :group_tags

  belongs_to :tag
end

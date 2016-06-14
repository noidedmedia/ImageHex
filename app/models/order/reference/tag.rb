class Order::Reference::Tag < ActiveRecord::Base
  belongs_to :order_reference,
    class_name: "Order::Reference"

  belongs_to :tag
end

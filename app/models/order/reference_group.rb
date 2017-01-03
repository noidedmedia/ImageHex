class Order::ReferenceGroup < ActiveRecord::Base
  belongs_to :order,
    inverse_of: :reference_groups,
    required: true

  has_many :images,
    class_name: "Order::ReferenceGroup::Image",
    foreign_key: :order_reference_group_id,
    dependent: :destroy

  has_many :reference_tags,
    class_name: "Order::ReferenceGroup::Tag",
    foreign_key: :order_reference_group_id,
    dependent: :destroy

  has_many :tags,
    class_name: "::Tag",
    through: :reference_tags

  validates :order,
    presence: true

  validates :description,
    presence: true

  accepts_nested_attributes_for :images,
    allow_destroy: true

end

require_dependency("order/reference_group/image.rb")
require_dependency("order/reference_group/tag.rb")

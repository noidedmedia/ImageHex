class Order::Reference < ActiveRecord::Base
  belongs_to :order
  belongs_to :category,
    class_name: "Listing::Category",
    foreign_key: :listing_category_id

  has_many :images,
    class_name: "Order::Reference::Image",
    foreign_key: :order_reference_id,
    dependent: :destroy

  validates :description,
    presence: true

  validates :order,
    presence: true

  accepts_nested_attributes_for :images

  validates :category,
    presence: true

  validate :reference_on_applicable_category


  private

  def reference_on_applicable_category
    unless order.listing == category.listing
      errors.add(:category, "must be on this order's listing")
    end
  end
end

require_dependency("order/reference/image.rb")

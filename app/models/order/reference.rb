class Order::Reference < ActiveRecord::Base
  belongs_to :order
  belongs_to :category,
    class_name: "Listing::Category",
    foreign_key: :listing_category_id

  validates :description,
    presence: true

  validates :order,
    presence: true

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

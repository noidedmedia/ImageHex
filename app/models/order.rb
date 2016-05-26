class Order < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user

  has_many :order_options,
    class_name: "Order::Option",
    inverse_of: :order

  has_many :options,
    class_name: "Listing::Option",
    through: :order_options

  has_many :references,
    class_name: "Order::Reference",
    inverse_of: :order

  accepts_nested_attributes_for :order_options

  validates :user, presence: true
  validates :listing, presence: true

  validate :not_order_to_self

  private

  def not_order_to_self
    unless user != listing.user
      errors.add(:user, "created this listing")
    end
  end
end

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

  accepts_nested_attributes_for :references

  validates :user, presence: true
  validates :listing, presence: true

  validate :not_order_to_self
  validate :order_has_references

  after_save :calculate_final_price

  def references_by_category
    h = Hash.new{|hash, key| hash[key] = []}
    self.references.each do |ref|
      h[ref.category] << ref
    end
    h
  end

  private

  def order_has_references
    if references.blank?
      errors.add(:references, "need at least 1")
    end
  end

  def not_order_to_self
    unless user != listing.user
      errors.add(:user, "created this listing")
    end
  end

  def calculate_final_price
    return unless final_price_needs_calculation?
    self.final_price = (self.listing.base_price + 
                        options_price +
                        references_price)
  end

  def final_price_needs_calculation?
    (self.confirmed? &&
     ! self.listing.quote_only &&
     self.final_price.nil?)
  end

  def options_price
    (options.map(&:price).reduce(:+) || 0)
  end

  def references_price
    (references_by_category.map do |val|
      category, refs = val
      paid_count = (refs.count - category.free_count)
      if paid_count > 0 then
        paid_count * category.price
      else
        0
      end
    end.reduce(:+) || 0)
  end
end

class Order::Option < ActiveRecord::Base
  belongs_to :order
  belongs_to :option,
    class_name: "Listing::Option",
    foreign_key: :listing_option_id

  validate :for_option_on_listing

  private
  def for_option_on_listing
    unless order.listing.options.include? option
      errors.add(:base, "not an option on this listing")
    end
  end
end

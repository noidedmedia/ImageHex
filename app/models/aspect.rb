class Aspect < ActiveRecord::Base
  belongs_to :order, required: true
  belongs_to :option, required: true
  validate :to_listing_option

  protected
  def to_listing_option
    unless order.listing.options.include? option
      errors.add(:option, "must be for this offer's listing")
    end
  end
end

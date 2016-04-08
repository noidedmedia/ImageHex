class Aspect < ActiveRecord::Base
  belongs_to :offer
  belongs_to :option
  validate :to_listing_option


  protected
  def to_listing_option
    unless offer.listing.options.include? option
      errors.add(:option, "must be for this offer's listing")
    end
  end
end

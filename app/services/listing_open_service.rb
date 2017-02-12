class ListingOpenService < ApplicationService
  def initialize(listing)
    @listing = listing
  end

  def perform
    validate!
    @listing.update(open: true)
  end

  class StripelessUserError < RuntimeError
    def initialize(msg = "")
      super
    end
  end

  protected
  def validate!
    unless @listing.user.stripe_user_id
      raise StripelessUserError
    end  
  end
end

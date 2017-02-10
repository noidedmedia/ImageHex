class ListingsPresenter < ApplicationPresenter
  def initialize(listings)
    @listings = listings
  end

  delegate_to :listings

  delegate_collection :listings
end

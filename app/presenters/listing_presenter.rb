class ListingPresenter < ApplicationPresenter
  def initialize(listing)
    @listing = listing
  end

  def user_avatar
    @listing.user.avatar_img_thumb
  end

  def username_link
    link_to @listing.user.name, @listing.user
  end

  def sample_images(num = 8)
    @listing.images.to_a.take(num)
  end

  def average_price
    attr = @listing.attributes["average_price"]
    return attr if @listing.attributes.has_key?("average_price")
    prices = @listing.orders.pluck(:final_price).compact
    return nil if prices.empty?
    prices.inject(:+) / prices.length
  end

  delegate_to :listing
end

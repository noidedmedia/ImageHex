class OrderPresenter < ApplicationPresenter
  def initialize(order)
    @order = order
  end

  def random_image
    @order.reference_images.sample.try(:f, :large)
  end

  def path
    listing_order_path(@order.listing, @order)
  end
  
  delegate_to :order

end

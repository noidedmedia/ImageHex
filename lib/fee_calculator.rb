class FeeCalculator
  def initialize(listing, order)
    @listing, @order = listing, order
  end

  def fee
    ((@order.final_price * 0.1) + 30).round
  end
end

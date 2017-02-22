class CommissionsDashboardPresenter::ListingsPresenter < ApplicationPresenter
  def initialize(listings)
    @listings = listings.preload(:orders).preload(:images)
  end

  autowrap :open,
    :unopen

  delegate_to :listings

  def open
    @listings.select(&:open?)
  end


  def closed
    @listings.reject(&:open?)
  end

  def types
    %w(open closed)
  end
end

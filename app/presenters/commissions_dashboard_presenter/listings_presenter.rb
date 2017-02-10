class CommissionsDashboardPresenter::ListingsPresenter < ApplicationPresenter
  def initialize(listings)
    @listings = listings.preload(:orders).preload(:images)
  end

  autowrap :open,
    :unopen,
    :draft

  delegate_to :listings

  def open
    @listings.select(&:open?)
  end


  def unopen
    @listings.reject(&:open?)
  end

  def draft
    @listings.reject(&:confirmed?)
  end

  def types
    %w(open unopen draft)
  end
end

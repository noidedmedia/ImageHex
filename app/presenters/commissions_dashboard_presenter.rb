class CommissionsDashboardPresenter < ApplicationPresenter
  def initialize(current_user)
    @user = current_user
  end

  memoize :placed, :received, :listings

  def placed
    OrdersPresenter.new(@user.orders)
  end

  def received
    OrdersPresenter.new(Order.to_user(@user).confirmed)
  end

  def listings
    ListingsPresenter.new(@user.listings.includes(:images))
  end
end

require_dependency("commissions_dashboard_presenter/orders_presenter")
require_dependency("commissions_dashboard_presenter/listings_presenter")

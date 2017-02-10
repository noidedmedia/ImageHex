class CommissionsDashboardPresenter::OrdersPresenter < ApplicationPresenter
  def initialize(orders)
    @orders = orders.preload(:reference_images)
      .preload(:listing)
  end

  autowrap :completed, 
    :rejected,
    :active,
    :pending,
    :draft,
    :unpaid

  
  def completed
    @orders.select{|o| o.image.present?}
  end

  def rejected
    @rejected ||= @orders.select(&:rejected?)
  end

  def active
    @active ||= @orders.select{|o| o.accepted? && o.image_id.nil?}
  end

  def pending
    @pending ||= @orders.select do |o| 
      ! o.accepted? && ! o.rejected? && o.confirmed?
    end
  end

  def draft
    @draft ||= @orders.select{|o| ! o.confirmed?}
  end

  def unpaid
    @unpaid ||= @orders.select{|o| o.accepted? && o.charge_id.nil?}
  end

  def types(for_customer = true)
    if for_customer
      %w(completed active pending rejected unpaid draft)
    else
      %(completed active pending unpaid)
    end
  end
end

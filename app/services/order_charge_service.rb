class OrderChargeService < ApplicationService
  def initialize(order, stripe_token)
    @order = order
    @stripe_token = stripe_token
  end

  def perform
    create_charge
    update_order
    send_notification
  end

  def create_charge
    @charge = Stripe::Charge.create({
      amount: @order.final_price,
      currency: "usd",
      source: @stripe_token,
      application_fee: calculate_fee,
      destination: @order.listing.user.stripe_user_id
    })
  end

  def calculate_fee
    FeeCalculator.new(@listing, @order).fee
  end

  def update_order
    @order.update(charge_id: @charge["id"],
                  charged_at: Time.at(@charge["created"]).utc.to_datetime)
  end

  def send_notification
    Notification.create(user: @order.listing.user,
                        kind: :order_paid,
                        subject: @order)
  end
end

class AddDueDateAndStripeChargeIdToCommissionOffers < ActiveRecord::Migration
  def change
    add_column :commission_offers, :due_at, :datetime
    add_column :commission_offers, :stripe_charge_id, :text
  end
end

class AddFilledToCommissionOffer < ActiveRecord::Migration
  def change
    add_column :commission_offers, :filled, :boolean,
      default: false,
      null: false
    add_column :commission_offers, :filled_at, :datetime
  end
end

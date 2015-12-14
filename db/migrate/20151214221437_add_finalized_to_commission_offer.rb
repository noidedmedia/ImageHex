class AddFinalizedToCommissionOffer < ActiveRecord::Migration
  def change
    add_column :commission_offers, :finalized, :boolean, null: false,
      default: false
    add_column :commission_offers, :finalized_at, :datetime
  end
end

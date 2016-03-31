class ChangeFinalizeToConfirm < ActiveRecord::Migration
  def change
    rename_column :commission_offers, :finalized, :confirmed
    rename_column :commission_offers, :finalized_at, :confirmed_at
  end
end

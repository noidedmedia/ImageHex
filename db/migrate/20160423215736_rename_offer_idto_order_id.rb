class RenameOfferIdtoOrderId < ActiveRecord::Migration
  def change
    rename_column :aspects, :offer_id, :order_id
  end
end

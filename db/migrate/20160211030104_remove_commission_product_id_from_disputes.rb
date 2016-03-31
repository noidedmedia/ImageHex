class RemoveCommissionProductIdFromDisputes < ActiveRecord::Migration
  def change
    remove_column :disputes, :commission_product_id
  end
end

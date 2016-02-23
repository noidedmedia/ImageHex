class AddConfirmedToCommissionProduct < ActiveRecord::Migration
  def change
    add_column :commission_products, :confirmed, :boolean, default: false,
      null: false
  end
end

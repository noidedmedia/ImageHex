class AddChargeIdAndChargedAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :charge_id, :text
    add_column :orders, :charged_at, :datetime
  end
end

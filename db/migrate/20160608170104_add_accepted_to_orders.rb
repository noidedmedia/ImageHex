class AddAcceptedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :accepted, :boolean,
      null: false, default: false
  end
end

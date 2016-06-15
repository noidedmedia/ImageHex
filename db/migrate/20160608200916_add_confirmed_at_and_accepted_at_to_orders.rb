class AddConfirmedAtAndAcceptedAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :confirmed_at, :timestamp
    add_column :orders, :accepted_at, :timestamp
  end
end

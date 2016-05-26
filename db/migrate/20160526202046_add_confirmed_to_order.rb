class AddConfirmedToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :confirmed, :boolean,
      null: false, default: false
  end
end

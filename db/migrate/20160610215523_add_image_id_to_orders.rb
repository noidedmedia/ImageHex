class AddImageIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :image_id, :integer
    add_column :orders, :filled_at, :timestamp
    add_foreign_key :orders, :images,
      on_delete: :restrict
  end
end

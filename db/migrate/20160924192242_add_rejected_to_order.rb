class AddRejectedToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :rejected, :boolean,
      null: false, default: false
  end
end

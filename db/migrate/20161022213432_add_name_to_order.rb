class AddNameToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :name, :string,
      null: false, default: ""
  end
end

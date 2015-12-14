class CreateCommissionProducts < ActiveRecord::Migration
  def change
    create_table :commission_products do |t|
      t.references :user, index: true
      t.string :name
      t.text :description
      t.integer :base_price
      t.timestamps null: false
    end
    add_foreign_key :commission_products, :users, on_delete: :cascade
  end
end

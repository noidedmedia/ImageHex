class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :user, index: true, foreign_key: {on_delete: :cascade}
      t.integer :base_price
      t.text :description, null: false
      t.string :name, null: false
      t.boolean :quote_only, null: false, default: :false

      t.timestamps null: false
    end
  end
end

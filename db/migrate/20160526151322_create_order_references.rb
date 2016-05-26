class CreateOrderReferences < ActiveRecord::Migration
  def change
    create_table :order_references do |t|
      t.references :order, index: true, foreign_key: true
      t.references :listing_category, index: true, foreign_key: true
      t.text :description, null: false
      t.timestamps null: false
    end
  end
end

class CreateOrderOptions < ActiveRecord::Migration
  def change
    create_table :order_options do |t|
      t.references :order, index: true, foreign_key: true
      t.references :listing_option, index: true, foreign_key: true
      t.timestamps null: false
    end

  end
end

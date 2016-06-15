class CreateOrderReferenceImages < ActiveRecord::Migration
  def change
    create_table :order_reference_images do |t|
      t.references :order_reference, index: true, foreign_key: true
      t.text :description, null: :false
      t.timestamps null: false
    end
    add_attachment :order_reference_images, :img
  end
end

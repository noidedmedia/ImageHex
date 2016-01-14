class CreateProductExampleImages < ActiveRecord::Migration
  def change
    create_table :product_example_images do |t|
      t.integer :commission_product_id, index: true
      t.integer :image_id, index: true
      t.timestamps null: false
    end
    add_foreign_key :product_example_images, :commission_products,
      on_delete: :cascade
    add_foreign_key :product_example_images, :images,
      on_delete: :cascade
  end
end

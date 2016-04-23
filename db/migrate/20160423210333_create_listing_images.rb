class CreateListingImages < ActiveRecord::Migration
  def change
    create_table :listing_images do |t|
      t.references :image, index: true
      t.references :listing, index: true
      t.timestamps null: false
    end
    add_foreign_key :listing_images, :listings,
      on_delete: :cascade
    add_foreign_key :listing_images, :images,
      on_delete: :cascade
  end
end

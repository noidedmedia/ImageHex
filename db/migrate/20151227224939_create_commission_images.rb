class CreateCommissionImages < ActiveRecord::Migration
  def change
    create_table :commission_images do |t|
      t.references :image, index: true
      t.references :commission_offer, index: true
      t.timestamps null: false
    end
    add_foreign_key :commission_images, :images,
      on_delete: :cascade
    add_foreign_key :commission_images, :commission_offers,
      on_delete: :cascade
  end
end

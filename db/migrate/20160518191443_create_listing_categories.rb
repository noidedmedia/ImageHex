class CreateListingCategories < ActiveRecord::Migration
  def change
    create_table :listing_categories do |t|
      t.references :listing, index: true
      t.integer :price, null: false
      t.integer :max_count, null: false
      t.integer :free_count, null: false
      t.timestamps null: false
    end

    add_foreign_key :listing_categories, :listings,
      on_delete: :cascade
  end

end

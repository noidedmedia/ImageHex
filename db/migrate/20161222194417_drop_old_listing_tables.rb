class DropOldListingTables < ActiveRecord::Migration[5.0]
  def change
    remove_column :order_references, :listing_category_id
    drop_table :listing_categories
    drop_table :subject_references
  end
end

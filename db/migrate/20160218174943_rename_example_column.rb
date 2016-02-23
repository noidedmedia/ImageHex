class RenameExampleColumn < ActiveRecord::Migration
  def change
    rename_column :listing_example_images,
      :commission_product_id,
      :listing_id
  end
end

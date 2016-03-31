class RenameProductExampleImageToListingExampleImage < ActiveRecord::Migration
  def change
    rename_table :product_example_images, :listing_example_images
  end
end

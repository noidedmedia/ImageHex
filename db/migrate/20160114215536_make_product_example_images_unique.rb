class MakeProductExampleImagesUnique < ActiveRecord::Migration
  def change
    add_index :product_example_images, [:commission_product_id,
                                        :image_id], unique: true, name: "unique_examples_images"
  end
end

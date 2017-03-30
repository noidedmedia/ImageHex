class AddIndexToCollectionImagesCreatedAt < ActiveRecord::Migration[5.0]
  def change
    add_index :collection_images, :created_at, unique: false
  end
end

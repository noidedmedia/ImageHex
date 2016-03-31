class CascadeCollectionImages < ActiveRecord::Migration
  def change
    remove_foreign_key :collection_images, :collections
    add_foreign_key :collection_images, :collections,
                    on_delete: :cascade
    remove_foreign_key :collection_images, :images
    add_foreign_key :collection_images, :images,
                    on_delete: :cascade
  end
end

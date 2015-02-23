class ForeignKeyIndexes < ActiveRecord::Migration
  def change
    add_foreign_key :tag_groups, :images
    add_foreign_key :images, :users
    add_foreign_key :comments, :users
    add_foreign_key :collection_images, :images
    add_foreign_key :collection_images, :collections
    add_index :collection_images, :collection_id
    add_index :collection_images, :image_id
    add_index :reports, :reportable_id
    add_index :reports, :reportable_type
    add_index :tracked_edits, :trackable_id
    add_index :tracked_edits, :trackable_type
  end
end

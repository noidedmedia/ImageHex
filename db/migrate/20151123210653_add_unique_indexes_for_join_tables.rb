class AddUniqueIndexesForJoinTables < ActiveRecord::Migration
  def change
    add_index :user_creations, [:user_id, :creation_id], unique: true
    add_index :artist_subscriptions, [:artist_id, :user_id], unique: true
    add_index :collection_images, [:collection_id, :image_id], unique: true
    add_index :tag_group_members, [:tag_group_id, :tag_id], unique: true
  end
end

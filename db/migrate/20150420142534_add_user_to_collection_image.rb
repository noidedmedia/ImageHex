class AddUserToCollectionImage < ActiveRecord::Migration
  def change
    add_reference :collection_images, :user, index: true
    add_foreign_key :collection_images, :users
  end
end

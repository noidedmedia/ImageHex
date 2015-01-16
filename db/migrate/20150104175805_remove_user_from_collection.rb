class RemoveUserFromCollection < ActiveRecord::Migration
  def change
    remove_column :collections, :user_id
  end
end

class AddUserIdToTagChanges < ActiveRecord::Migration
  def change
    add_column :tag_changes, :user_id, :integer
    add_foreign_key :tag_changes, :users, on_delete: :cascade
  end
end

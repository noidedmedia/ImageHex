class AddImportanceToTagChanges < ActiveRecord::Migration
  def change
    add_column :tag_changes, :importance, :integer, null: false, default: 1
  end
end

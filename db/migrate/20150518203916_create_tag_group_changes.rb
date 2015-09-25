class CreateTagGroupChanges < ActiveRecord::Migration
  def change
    create_table :tag_group_changes do |t|
      t.references :tag_group, index: true
      t.references :user, index: true
      t.integer :kind
      t.timestamps null: false
      t.integer :before, array: true, default: []
      t.integer :after, array: true, default: []
    end
    add_foreign_key :tag_group_changes, :tag_groups, on_delete: :cascade
    add_foreign_key :tag_group_changes, :users, on_delete: :nullify
  end
end

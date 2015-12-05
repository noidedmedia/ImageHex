class CreateTagChanges < ActiveRecord::Migration
  def change
    create_table :tag_changes do |t|
      t.integer :tag_id
      t.text :name
      t.text :description
      t.timestamps null: false
    end
    add_foreign_key :tag_changes, :tags, on_delete: :cascade
    add_index :tag_changes, :tag_id
  end
end

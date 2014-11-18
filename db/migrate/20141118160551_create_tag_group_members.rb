class CreateTagGroupMembers < ActiveRecord::Migration
  def change
    create_table :tag_group_members do |t|
      t.references :tag_group, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end

class CreateTagGroups < ActiveRecord::Migration
  def change
    create_table :tag_groups do |t|
      t.references :image, index: true

      t.timestamps
    end
  end
end

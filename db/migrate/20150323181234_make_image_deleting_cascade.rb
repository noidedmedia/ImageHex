class MakeImageDeletingCascade < ActiveRecord::Migration
  def change
    remove_foreign_key :tag_groups, :images
    add_foreign_key :tag_groups, :images, on_delete: :cascade
  end
end

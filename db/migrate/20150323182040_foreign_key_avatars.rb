class ForeignKeyAvatars < ActiveRecord::Migration
  def change
    add_foreign_key :users, :images, column: :avatar_id, on_delete: :nullify
  end
end

class CreateUserCreations < ActiveRecord::Migration
  def change
    create_table :user_creations do |t|
      t.integer :user_id, null: false
      t.integer :creation_id, null: false
      t.timestamps null: false
    end
    add_index(:user_creations, :user_id)
    add_index(:user_creations, :creation_id)
    add_foreign_key :user_creations, :users, on_delete: :cascade
    add_foreign_key :user_creations, :images, column: :creation_id, on_delete: :cascade
  end
end

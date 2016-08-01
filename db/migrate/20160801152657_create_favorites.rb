class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.references :image
      t.references :user
      t.timestamps
    end
    add_foreign_key :favorites, :images, on_delete: :cascade
    add_foreign_key :favorites, :users, on_delete: :cascade
    add_index :favorites, [:user_id, :image_id], unique: true
  end
end

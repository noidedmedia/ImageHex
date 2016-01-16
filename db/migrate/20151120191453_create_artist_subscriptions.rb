class CreateArtistSubscriptions < ActiveRecord::Migration
  def change
    create_table :artist_subscriptions do |t|
      t.integer :user_id
      t.integer :artist_id
      t.timestamps null: false
    end
    add_index :artist_subscriptions, :user_id
    add_index :artist_subscriptions, :artist_id
    add_foreign_key :artist_subscriptions, :users, on_delete: :cascade
    add_foreign_key :artist_subscriptions, :users, column: :artist_id, on_delete: :cascade
  end
end

class MakeThingsNonNull < ActiveRecord::Migration
  def change
    change_column :artist_subscriptions, :user_id, :integer, null: :false
    change_column :artist_subscriptions, :artist_id, :integer, null: false
  end
end

class AddContentPrefToUsers < ActiveRecord::Migration
  def change
    add_column :users, :content_pref, :jsonb, default: {}, null: false
  end
end

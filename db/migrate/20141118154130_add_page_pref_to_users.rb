class AddPagePrefToUsers < ActiveRecord::Migration
  def change
    # We display 20 images per page by default
    add_column :users, :page_pref, :integer, default: 20
  end
end

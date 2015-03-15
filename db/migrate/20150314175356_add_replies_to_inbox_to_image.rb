class AddRepliesToInboxToImage < ActiveRecord::Migration
  def change
    add_column :images, :replies_to_inbox, :boolean, default: false
  end
end

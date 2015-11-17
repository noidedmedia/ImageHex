class MakeRepliesToInboxTrueByDefault < ActiveRecord::Migration
  def change
    change_column :images, :replies_to_inbox, :boolean, default: true, null: false
  end
end

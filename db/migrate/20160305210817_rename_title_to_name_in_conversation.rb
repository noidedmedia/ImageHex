class RenameTitleToNameInConversation < ActiveRecord::Migration
  def change
    rename_column :conversations, :title, :name
  end
end

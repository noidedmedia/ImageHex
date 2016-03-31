class AddTitleToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :title, :string,
      null: false,
      default: "Untitled Conversation"
  end
end

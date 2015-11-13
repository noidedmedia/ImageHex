class RenameConversationMessagesToMessages < ActiveRecord::Migration
  def change
    rename_table :conversation_messages, :messages
  end
end

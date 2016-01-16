class UniqueIndexConversationUsers < ActiveRecord::Migration
  def change
    add_index :conversation_users, [:user_id, :conversation_id],
              unique: true
  end
end

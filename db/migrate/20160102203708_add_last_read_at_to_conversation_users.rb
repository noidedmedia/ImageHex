class AddLastReadAtToConversationUsers < ActiveRecord::Migration
  def change
    add_column :conversation_users, :last_read_at, :datetime
  end
end

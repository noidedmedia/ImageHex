class AddLastMessageAtToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :last_message_at, :datetime
  end
end

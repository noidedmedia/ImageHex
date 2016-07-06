class AddAcceptedToConversationUser < ActiveRecord::Migration[5.0]
  def change
    add_column :conversation_users, :accepted, :boolean
  end
end

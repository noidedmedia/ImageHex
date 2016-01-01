class CreateConversationUsers < ActiveRecord::Migration
  def change
    create_table :conversation_users do |t|
      t.references :user, index: true
      t.references :conversation, index: true
      t.timestamps null: false
    end
    add_foreign_key :conversation_users, :users,
      on_delete: :cascade
    add_foreign_key :conversation_users, :conversations,
      on_delete: :cascade
  end
end

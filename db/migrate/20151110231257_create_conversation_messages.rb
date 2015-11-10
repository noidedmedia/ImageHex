class CreateConversationMessages < ActiveRecord::Migration
  def change
    create_table :conversation_messages do |t|
      t.references :conversation, index: true
      t.references :user, index: true
      t.text :body
      t.timestamps null: false
    end
    add_foreign_key :conversation_messages, :users, on_delete: :cascade
    add_foreign_key :conversation_messages, :conversations, on_delete: :cascade
  end
end

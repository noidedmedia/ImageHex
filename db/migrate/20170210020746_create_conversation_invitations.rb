class CreateConversationInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversation_invitations do |t|
      t.references :conversation, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.datetime :accepted_at, null: true
      t.datetime :rejected_at, null: true
      t.timestamps
    end
  end
end

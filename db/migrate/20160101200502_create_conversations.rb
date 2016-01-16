class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :commission_offer_id, null: true
      t.timestamps null: false
    end
    add_index :conversations, :commission_offer_id
    add_foreign_key :conversations, :commission_offers,
                    on_delete: :nullify
  end
end

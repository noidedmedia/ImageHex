class AddOrderIdToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :order_id, :integer, null: true
    add_foreign_key :conversations, :orders,
      on_delete: :nullify
  end
end

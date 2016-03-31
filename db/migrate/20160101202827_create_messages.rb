class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.references :conversation, index: true
      t.boolean :read, null: true
      t.datetime :read_at, null: true
      t.timestamps null: false
    end
    add_foreign_key :messages, :users,
                    on_delete: :cascade
    add_foreign_key :messages, :conversations,
                    on_delete: :cascade
  end
end

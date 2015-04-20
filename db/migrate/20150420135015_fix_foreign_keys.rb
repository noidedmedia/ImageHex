class FixForeignKeys < ActiveRecord::Migration
  def change
    remove_foreign_key :curatorships, :collections
    add_foreign_key :curatorships, :collections, on_delete: :cascade
    remove_foreign_key :curatorships, :users
    add_foreign_key :curatorships, :users, on_delete: :cascade
  end
end

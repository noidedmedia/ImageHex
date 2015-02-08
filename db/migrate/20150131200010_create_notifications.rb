class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :subject, polymorphic: true, index: true
      t.text :message
      t.boolean :read, null: false, default: false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
  end
end

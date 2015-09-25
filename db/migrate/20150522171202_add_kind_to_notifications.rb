class AddKindToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :kind, :integer
  end
end

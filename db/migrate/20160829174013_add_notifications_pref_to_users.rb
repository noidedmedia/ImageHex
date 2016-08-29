class AddNotificationsPrefToUsers < ActiveRecord::Migration[5.0]
  def change
    default_pref = {
      new_subscriber: true,
      order_confirmed: true,
      order_accepted: true,
      order_paid: true,
      order_filled: true
    }
    add_column :users, :notifications_pref, :jsonb, null: false,
      default: default_pref
  end
end

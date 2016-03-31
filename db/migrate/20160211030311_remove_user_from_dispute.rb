class RemoveUserFromDispute < ActiveRecord::Migration
  def change
    remove_column :disputes, :user_id
  end
end

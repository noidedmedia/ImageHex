class DropDisputes < ActiveRecord::Migration[5.0]
  def change
    drop_table :disputes
  end
end

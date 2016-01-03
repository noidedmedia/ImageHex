class RemoveReadFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :read
    remove_column :messages, :read_at
  end
end

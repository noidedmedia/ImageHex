class AddElsewhereToUsers < ActiveRecord::Migration
  def change
    add_column :users, :elsewhere, :jsonb
  end
end

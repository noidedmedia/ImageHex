class AddResolvedToDispute < ActiveRecord::Migration[5.0]
  def change
    add_column :disputes, :resolved, :boolean,
      default: false, null: false
  end
end

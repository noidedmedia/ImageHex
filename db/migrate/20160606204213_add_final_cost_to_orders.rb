class AddFinalCostToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :final_cost, :integer
  end
end

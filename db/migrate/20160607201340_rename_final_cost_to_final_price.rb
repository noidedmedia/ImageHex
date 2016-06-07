class RenameFinalCostToFinalPrice < ActiveRecord::Migration
  def change
    rename_column :orders, :final_cost, :final_price
  end
end

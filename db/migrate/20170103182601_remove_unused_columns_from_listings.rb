class RemoveUnusedColumnsFromListings < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings,
      :quote_only
    remove_column :listings,
      :base_price

  end
end

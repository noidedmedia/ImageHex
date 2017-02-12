class RemoveConfirmedFromListings < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :confirmed
  end
end

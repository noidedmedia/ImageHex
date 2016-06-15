class RenameOfferToOrder < ActiveRecord::Migration
  def change
    rename_table :offers, :orders
  end
end

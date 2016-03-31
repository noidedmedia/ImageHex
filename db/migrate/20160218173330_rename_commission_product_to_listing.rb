class RenameCommissionProductToListing < ActiveRecord::Migration
  def change
    rename_table :commission_products, :listings
  end
end

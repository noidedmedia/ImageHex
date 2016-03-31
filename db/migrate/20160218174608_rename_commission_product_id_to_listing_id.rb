class RenameCommissionProductIdToListingId < ActiveRecord::Migration
  def change
    rename_column :commission_offers,
      :commission_product_id,
      :listing_id
  end
end

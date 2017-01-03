class RemoveListingOptions < ActiveRecord::Migration[5.0]
  def change
    drop_table :order_options
    drop_table :listing_options
  end
end

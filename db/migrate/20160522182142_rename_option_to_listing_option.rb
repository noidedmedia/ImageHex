class RenameOptionToListingOption < ActiveRecord::Migration
  def change
    rename_table :options, :listing_options
  end
end

class RenameIncludesBackgroundToOffersBackground < ActiveRecord::Migration
  def change
    rename_column :commission_products, :includes_background, :include_background
  end
end

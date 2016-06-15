class AddNameAndDescriptionToListingCategories < ActiveRecord::Migration
  def change
    add_column :listing_categories, :name, :text, null: false
    add_column :listing_categories, :description, :text, null: false
  end
end

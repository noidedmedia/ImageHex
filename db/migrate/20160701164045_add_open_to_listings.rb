class AddOpenToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :open, :boolean,
      null: false,
      default: false
  end
end

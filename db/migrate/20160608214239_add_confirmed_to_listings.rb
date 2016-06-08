class AddConfirmedToListings < ActiveRecord::Migration
  def change
    add_column :listings, :confirmed, :boolean,
      null: false, default: false
  end
end

class AddInfoToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :info, :jsonb
  end
end

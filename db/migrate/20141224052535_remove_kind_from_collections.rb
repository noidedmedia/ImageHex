class RemoveKindFromCollections < ActiveRecord::Migration
  def change
    remove_column :collections, :kind, :integer
  end
end

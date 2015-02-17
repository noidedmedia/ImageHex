class AddKindToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :kind, :integer
  end
end

class DropTypeFromCollection < ActiveRecord::Migration[5.0]
  def change
    remove_column :collections, :type
  end
end

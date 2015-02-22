class AddDisplayNameToTag < ActiveRecord::Migration
  def change
    add_column :tags, :display_name, :string
  end
end

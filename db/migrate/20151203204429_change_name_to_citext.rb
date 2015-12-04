class ChangeNameToCitext < ActiveRecord::Migration
  def change
    enable_extension 'citext'
    change_column :tags, :name, :citext
    remove_column :tags, :display_name
  end
end

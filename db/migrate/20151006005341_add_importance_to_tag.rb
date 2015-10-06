class AddImportanceToTag < ActiveRecord::Migration
  def change
    add_column :tags, :importance, :integer
  end
end

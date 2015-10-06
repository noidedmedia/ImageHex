class MakeImportanceNonNull < ActiveRecord::Migration
  def change
    change_column :tags, :importance, :integer, null: false, default: 1
  end
end

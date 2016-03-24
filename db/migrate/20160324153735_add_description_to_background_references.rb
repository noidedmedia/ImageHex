class AddDescriptionToBackgroundReferences < ActiveRecord::Migration
  def change
    add_column :background_references, :description, :text
  end
end

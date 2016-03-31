class AddDescriptionToSubjectReferences < ActiveRecord::Migration
  def change
    add_column :subject_references, :description, :text
  end
end

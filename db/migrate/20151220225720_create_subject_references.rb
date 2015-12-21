class CreateSubjectReferences < ActiveRecord::Migration
  def change
    create_table :subject_references do |t|
      t.references :commission_subject, index: true
      t.timestamps null: false
      t.attachment :file
    end
    add_foreign_key :subject_references, :commission_subjects,
      on_delete: :cascade
  end
end

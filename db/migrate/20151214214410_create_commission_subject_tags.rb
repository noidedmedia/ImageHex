class CreateCommissionSubjectTags < ActiveRecord::Migration
  def change
    create_table :commission_subject_tags do |t|
      t.references :tag, index: true, null: false
      t.references :commission_subject, index: true, null: false
      t.timestamps null: false
    end
    add_foreign_key :commission_subject_tags, :tags, on_delete: :cascade
    add_foreign_key :commission_subject_tags, :commission_subjects,
      on_delete: :cascade
  end
end

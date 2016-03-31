class MakeBackgroundReferencesReferenceBackground < ActiveRecord::Migration
  def change
    add_column :background_references,
               :commission_background_id,
               :integer,
               null: false
    add_index :background_references, :commission_background_id
    add_foreign_key :background_references, :commission_backgrounds,
                    on_delete: :cascade
  end
end

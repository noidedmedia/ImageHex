class CreateOrderReferenceTags < ActiveRecord::Migration
  def change
    create_table :order_reference_tags do |t|
      t.integer :order_reference_id, null: false
      t.integer :tag_id, null: false
      t.timestamps null: false
    end
    add_foreign_key :order_reference_tags,
      :order_references,
      on_delete: :cascade

    add_foreign_key :order_reference_tags,
      :tags,
      on_delete: :cascade
  end
end

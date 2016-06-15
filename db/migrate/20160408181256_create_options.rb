class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :listing, index: true, foreign_key: {on_delete: :cascade}
      t.integer :price
      t.boolean :reference_category, null: false,
        default: false
      t.integer :max_allowed, null: false,
        default: 1
      t.string :name, null: false,
        default: ""
      t.text :description, null: false,
        defualt: ""

      t.timestamps null: false
    end
  end
end

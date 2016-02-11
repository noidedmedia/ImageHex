class CreateDisputes < ActiveRecord::Migration
  def change
    create_table :disputes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :commission_offer, index: true, foreign_key: true
      t.references :commission_product, index: true, foreign_key: true
      t.text :description
      t.boolean :resolved, default: false, null: false

      t.timestamps null: false
    end
  end
end

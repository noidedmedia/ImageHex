class CreateCommissionBackgrounds < ActiveRecord::Migration
  def change
    create_table :commission_backgrounds do |t|
      t.references :commission_offer, index: true, foreign_key: true,
        null: false
      t.text :description

      t.timestamps null: false
    end
  end
end

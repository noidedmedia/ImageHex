class CreateCommissionOffers < ActiveRecord::Migration
  def change
    create_table :commission_offers do |t|
      t.references :commission_product, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :total_price
      t.text :description
      t.datetime :charged_at
      # Accepted is created as null
      t.boolean :accepted
      t.datetime :accepted_at
      t.timestamps null: false
    end
  end
end

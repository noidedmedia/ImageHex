class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :listing, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :description
      t.timestamps null: false
    end
  end
end

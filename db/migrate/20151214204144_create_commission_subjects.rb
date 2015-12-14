class CreateCommissionSubjects < ActiveRecord::Migration
  def change
    create_table :commission_subjects do |t|
      t.references :commission_offer, index: true, foreign_key: true,
        null: false
      t.text :description
      t.timestamps null: false
    end
  end
end

class CreateAspects < ActiveRecord::Migration
  def change
    create_table :aspects do |t|
      t.references :offer, index: true, foreign_key: true
      t.references :option, index: true, foreign_key: true
      t.text :description 

      t.timestamps null: false
    end
  end
end

class CreateDisputes < ActiveRecord::Migration[5.0]
  def change
    create_table :disputes do |t|
      t.text :description
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end

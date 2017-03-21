class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end

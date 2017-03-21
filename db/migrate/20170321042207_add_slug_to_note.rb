class AddSlugToNote < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :slug, :string
    add_index :notes, :slug, unique: true
  end
end

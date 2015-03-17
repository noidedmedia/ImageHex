class CreateUserPages < ActiveRecord::Migration
  def change
    create_table :user_pages do |t|
      t.string :markdown
      t.string :compiled
      t.references :user, index: true
      t.jsonb :elsewhere

      t.timestamps null: false
    end
    add_foreign_key :user_pages, :users
  end
end

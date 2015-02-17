class CreateCuratorships < ActiveRecord::Migration
  def change
    create_table :curatorships do |t|
      t.references :user, index: true
      t.references :collection, index: true

      t.timestamps null: false
    end
    add_foreign_key :curatorships, :users
    add_foreign_key :curatorships, :collections
  end
end

class CreateCollectionImages < ActiveRecord::Migration
  def change
    create_table :collection_images do |t|
      t.references :collection
      t.references :image
      t.timestamps
    end
  end
end

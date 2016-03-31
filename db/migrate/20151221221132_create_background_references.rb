class CreateBackgroundReferences < ActiveRecord::Migration
  def change
    create_table :background_references do |t|
      t.attachment :file
      t.timestamps null: false
    end
  end
end

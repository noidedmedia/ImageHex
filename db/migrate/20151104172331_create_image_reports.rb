class CreateImageReports < ActiveRecord::Migration
  def change
    create_table :image_reports do |t|
      t.references :image, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :reason

      t.timestamps null: false
    end
  end
end

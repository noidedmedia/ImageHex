class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :severity
      t.string :message
      t.references :reportable, polymorphic: true
      t.timestamps
    end
  end
end

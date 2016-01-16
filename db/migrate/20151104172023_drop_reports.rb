class DropReports < ActiveRecord::Migration
  def up
    drop_table :reports
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end

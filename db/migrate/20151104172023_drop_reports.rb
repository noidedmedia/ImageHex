class DropReports < ActiveRecord::Migration
  def up
    drop_table :reports
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

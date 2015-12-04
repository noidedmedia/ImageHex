class AddActiveToReports < ActiveRecord::Migration
  def change
    add_column :image_reports, :active, :boolean, null: false, default: true
  end
end

class AddMessageToImageReports < ActiveRecord::Migration
  def change
    add_column :image_reports, :message, :text
  end
end

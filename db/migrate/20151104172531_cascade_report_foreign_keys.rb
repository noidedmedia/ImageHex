class CascadeReportForeignKeys < ActiveRecord::Migration
  def change
    remove_foreign_key :image_reports, :images
    remove_foreign_key :image_reports, :users
    add_foreign_key :image_reports, :images, on_delete: :cascade
    add_foreign_key :image_reports, :users, on_delete: :cascade
  end
end

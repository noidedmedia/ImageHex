class AddJsonbSubjectToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :subject, :jsonb, null: false, default: {}
  end
end

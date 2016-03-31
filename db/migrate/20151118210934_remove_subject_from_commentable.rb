class RemoveSubjectFromCommentable < ActiveRecord::Migration
  def change
    remove_column :notifications, :subject_id
    remove_column :notifications, :subject_type
  end
end

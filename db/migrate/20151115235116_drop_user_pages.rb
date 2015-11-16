class DropUserPages < ActiveRecord::Migration
  def change
    drop_table :user_pages
  end
end

class RefactorUserPages < ActiveRecord::Migration
  def change
    remove_column :user_pages, :compiled
    remove_column :user_pages, :markdown
    add_column :user_pages, :body, :text
  end
end

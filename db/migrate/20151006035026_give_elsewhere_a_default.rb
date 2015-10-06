class GiveElsewhereADefault < ActiveRecord::Migration
  def change
    change_column :user_pages, :elsewhere, :jsonb, default: {}, null: false
  end
end

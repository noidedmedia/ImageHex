class AddUseInfiniteScrollToUsers < ActiveRecord::Migration
  def change
    add_column :users, :use_infinite_scroll, :boolean,
      null: false,
      default: true
  end
end

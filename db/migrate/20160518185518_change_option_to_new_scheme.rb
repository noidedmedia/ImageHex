class ChangeOptionToNewScheme < ActiveRecord::Migration
  def change
    remove_column :options, :reference_category
    remove_column :options, :max_allowed
    remove_column :options, :free_count
  end
end

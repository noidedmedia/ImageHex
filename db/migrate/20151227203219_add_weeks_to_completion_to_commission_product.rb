class AddWeeksToCompletionToCommissionProduct < ActiveRecord::Migration
  def change
    add_column :commission_products, :weeks_to_completion, :integer,
      null: false,
      default: 4
  end
end

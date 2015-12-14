class AddMoreFieldsToCommissionProduct < ActiveRecord::Migration
  def change
    change_column :commission_products, :base_price, :integer,
      null: false, default: 1000
    add_column :commission_products, :included_subjects, :integer,
      null: false, default: 0
    add_column :commission_products, :includes_background, :boolean,
      default: false, null: false
    add_column :commission_products, :subject_price, :integer,
      null: false, default: 500
    # if null, you can't add a background
    add_column :commission_products, :background_price, :integer
    # if non-null, limit the amount of subjects allowed 
    add_column :commission_products, :maximum_subjects, :integer
  end
end

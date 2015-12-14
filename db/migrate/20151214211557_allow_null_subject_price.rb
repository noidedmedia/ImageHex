class AllowNullSubjectPrice < ActiveRecord::Migration
  def change
    change_column :commission_products, :subject_price, :integer,
      null: true
  end
end

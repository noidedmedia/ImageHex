class DefaultToNullSubjectPrices < ActiveRecord::Migration
  def change
    change_column_default(:commission_products, :subject_price, nil)
  end
end

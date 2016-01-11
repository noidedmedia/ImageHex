class AllowNullableCommissionProductInCommissionOffer < ActiveRecord::Migration
  def change
    change_column :commission_offers,
      :commission_product_id,
      :integer,
      null: true
  end
end

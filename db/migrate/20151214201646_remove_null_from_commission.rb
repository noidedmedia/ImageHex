class RemoveNullFromCommission < ActiveRecord::Migration
  def change
    change_column :commission_products, :user_id, :integer,
                  null: false
    change_column :commission_offers, :commission_product_id, :integer,
                  null: false
    change_column :commission_offers, :user_id, :integer,
                  null: false
  end
end

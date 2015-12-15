class AddOfferBackgroundAndOfferSubjectsToCommissionProduct < ActiveRecord::Migration
  def change
    add_column :commission_products, :offer_background, :boolean, null: false,
      default: true
    add_column :commission_products, :offer_subjects, :boolean, null: false,
      default: true
  end
end

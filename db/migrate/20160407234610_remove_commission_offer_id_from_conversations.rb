class RemoveCommissionOfferIdFromConversations < ActiveRecord::Migration
  def change
    remove_column :conversations, :commission_offer_id
  end
end

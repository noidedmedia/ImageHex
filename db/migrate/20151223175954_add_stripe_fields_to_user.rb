class AddStripeFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users,
               :stripe_publishable_key,
               :text
    add_column :users,
               :stripe_access_token,
               :text
    add_column :users,
               :stripe_user_id,
               :text
  end
end

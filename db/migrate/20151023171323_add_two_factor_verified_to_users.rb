class AddTwoFactorVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :two_factor_verified, :boolean, null: false, default: false
  end
end

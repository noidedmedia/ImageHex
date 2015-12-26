class AddDeviseTwoFactorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_otp_secret, :string unless column_exists? :users, :encrypted_otp_secret
    add_column :users, :encrypted_otp_secret_iv, :string unless column_exists? :users, :encrypted_otp_secret_iv
    add_column :users, :encrypted_otp_secret_salt, :string unless column_exists? :users, :encrypted_otp_secret_salt
    add_column :users, :consumed_timestep, :integer unless column_exists? :users, :consumed_timestep
    add_column :users, :otp_required_for_login, :boolean unless column_exists? :users, :otp_required_for_login
  end
end

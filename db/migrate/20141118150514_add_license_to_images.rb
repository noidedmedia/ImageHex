class AddLicenseToImages < ActiveRecord::Migration
  def change
    add_column :images, :license, :integer
  end
end

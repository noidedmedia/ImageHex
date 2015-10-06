class AddFFileSizeToImages < ActiveRecord::Migration
  def change
    add_column :images, :f_file_size, :integer
  end
end

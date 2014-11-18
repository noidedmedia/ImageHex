class AddMediumToImages < ActiveRecord::Migration
  def change
    add_column :images, :medium, :integer
  end
end

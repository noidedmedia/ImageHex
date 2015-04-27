class AddLevelToCuratorship < ActiveRecord::Migration
  def change
    add_column :curatorships, :level, :integer
  end
end

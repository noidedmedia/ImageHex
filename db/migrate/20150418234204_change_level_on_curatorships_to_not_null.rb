class ChangeLevelOnCuratorshipsToNotNull < ActiveRecord::Migration
  def change
    change_column :curatorships, :level, :integer, null: false, default: 0
  end
end

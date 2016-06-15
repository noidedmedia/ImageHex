class DropAspects < ActiveRecord::Migration
  def change
    drop_table :aspects
  end
end

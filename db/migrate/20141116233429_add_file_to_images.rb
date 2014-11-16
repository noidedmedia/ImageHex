class AddFileToImages < ActiveRecord::Migration
  def self.up
    add_attachment :images, :f
  end
  def self.down
    add_attachment :images, :f
  end
end

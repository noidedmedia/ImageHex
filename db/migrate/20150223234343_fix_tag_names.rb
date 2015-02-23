class FixTagNames < ActiveRecord::Migration
  def data
    Tag.find_each do |tag|
      tag.display_name = tag.name
      tag.save
    end
  end
end

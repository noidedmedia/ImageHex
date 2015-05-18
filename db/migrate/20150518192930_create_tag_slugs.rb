class CreateTagSlugs < ActiveRecord::Migration
  def data
    Tag.find_all(&:save)
  end
end

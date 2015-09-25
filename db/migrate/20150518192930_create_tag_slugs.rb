class CreateTagSlugs < ActiveRecord::Migration
  def data
    Tag.find_each(&:save)
  end
end

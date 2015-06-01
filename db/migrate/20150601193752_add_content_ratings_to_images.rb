class AddContentRatingsToImages < ActiveRecord::Migration
  def change
    add_column :images, :nsfw_language, :boolean
    add_column :images, :nsfw_nudity, :boolean
    add_column :images, :nsfw_gore, :boolean
    add_column :images, :nsfw_sexuality, :boolean
  end
end

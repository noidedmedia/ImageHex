class MakeImageRatingsNonNull < ActiveRecord::Migration
  def change
    change_column :images, :nsfw_language, :boolean, null: false, default: false
    change_column :images, :nsfw_nudity, :boolean, null: false, default: false
    change_column :images, :nsfw_gore, :boolean, null: false, default: false
    change_column :images, :nsfw_sexuality, :boolean, null: false, default: false
  end
end

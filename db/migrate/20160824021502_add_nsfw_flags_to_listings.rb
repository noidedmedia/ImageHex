class AddNsfwFlagsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :nsfw_nudity, :boolean,
      default: false, null: false
    add_column :listings, :nsfw_gore, :boolean,
      default: false, null: false
    add_column :listings, :nsfw_language, :boolean,
      default: false, null: false
    add_column :listings, :nsfw_sexuality, :boolean,
      default: false, null: false
  end
end

class AddSlugToTagTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :tag_topics, :slug, :string
    add_index :tag_topics, :slug, unique: true
  end
end

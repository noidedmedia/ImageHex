class CreateTagTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_topics do |t|
      t.references :tag, foreign_key: true
      t.references :user, foreign_key: true
      t.text :title

      t.timestamps
    end
  end
end

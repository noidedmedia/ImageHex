class CreateTagTopicReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_topic_replies do |t|
      t.references :tag_topic
      t.references :user
      t.text :body
      t.timestamps
    end

    add_foreign_key :tag_topic_replies, :tag_topics,
      on_delete: :cascade

    add_foreign_key :tag_topic_replies, :users,
      on_delete: :cascade
  end
end

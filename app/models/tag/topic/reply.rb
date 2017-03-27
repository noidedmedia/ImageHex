class Tag::Topic::Reply < ApplicationRecord
  belongs_to :topic,
    class_name: "Tag::Topic",
    foreign_key: :tag_topic_id,
    required: true,
    touch: true,
    inverse_of: :replies

  belongs_to :user,
    required: true
end

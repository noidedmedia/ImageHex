class Note::Reply < ApplicationRecord
  belongs_to :user
  belongs_to :note

  def parent_id
    note.id
  end

  def parent_type
    note.class.name
  end
end

require 'set'

class NoteIndexService < ApplicationService
  def initialize(query)
    @collection = Note.all
    query.each do |k, v|
      if ALLOWED_QUERIES.include?(k)
        @collection = self.send(k, v)
      end
    end
  end

    ALLOWED_QUERIES = ["user_id"].to_set

  def get_notes
    @collection
  end

  protected
  def user_id(id)
    @collection.where(user_id: id)
  end
end

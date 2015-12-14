class TagTracker < ApplicationTracker
  def create
    make_change
  end

  def update_before
    ## Do nothing
  end

  def update_after
    make_change
  end

  protected
  def make_change
    TagChange.create(tag: @record,
                     user: @user,
                     description: @record.description,
                     importance: @record.importance,
                     name: @record.name)
  end
end

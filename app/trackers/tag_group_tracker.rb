# frozen_string_literal: true
class TagGroupTracker < ApplicationTracker
  def create
    TagGroupChange.create(tag_group: @record,
                          user: @user,
                          before: [],
                          after: @record.tags.pluck(:id),
                          kind: :created)
  end

  def update_before
    @old_tags = @record.tags.pluck(:id)
  end

  def update_after
    @new_tags = @record.reload.tags.pluck(:id)
    TagGroupChange.create(tag_group: @record,
                          user: @user,
                          before: @old_tags,
                          after: @new_tags,
                          kind: :created)
  end
end

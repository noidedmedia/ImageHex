class TagGroupTracker < ApplicationTracker
  def update_before
    10.times{puts "#"}
    @old_tags = @record.tags.pluck(:id)
  end

  def update_after
    @new_tags = @record.reload.tags.pluck(:id)
    puts "OLD TAGS: #{@old_tags.inspect}"
    puts "NEW TAGS: #{@new_tags.inspect}"
    puts "ADDED: #{@new_tags - @old_tags}"
    puts "REMOVED: #{@old_tags - @new_tags}"
  end

end

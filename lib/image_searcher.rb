module ImageSearcher
  ##
  # Run the (kind of messy) sql to find images
  def self.search(q)
    names = q.map{|x| x.split(",").map{|y| y.downcase.strip.squish}}
    names.map!{|x| arel_query(x)}
    full = names.inject{|c, q| c.intersect(q)}
    ImageSearchResults.new(full)
  end

  private
  def self.arel_query(q)
    images = Image.arel_table
    tag_groups = TagGroup.arel_table
    tag_group_members = TagGroupMember.arel_table
    tags = Tag.arel_table
    c = images
      .join(tag_groups).on(tag_groups[:image_id].eq(images[:id]))
      .join(tag_group_members).on(tag_group_members[:tag_group_id].eq(tag_groups[:id]))
      .join(tags).on(tag_group_members[:tag_id].eq(tags[:id]))
      .where(tags[:name].in(q))
      .group(images[:id])
      .having(Arel.sql('*').count.eq(q.length))
      .project("images.*")
    return c
  end
end


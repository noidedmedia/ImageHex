module ImageHex
  class TagGroupSearcher
    def initialize(tag_group_names)
      # "refine" narrows our results by the tags in a tag group.
      # We assume we just get arrays of strings which are
      # the names of the tags in the groups
      groups = tag_groups_names.map{|x| self.get_groups x }
      # Now we find all images with those tag groups
      @images = Image.where(tag_groups: groups)
      return @images
    end
    attr_reader :images
    def get_groups(tag_group)
      tags = Tag.where(name: tag_group)
      groups = TagGroup.where(tags: tags)
    end
  end
end


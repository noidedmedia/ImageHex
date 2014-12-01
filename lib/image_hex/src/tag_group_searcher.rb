module ImageHex
  class TagGroupSearcher
    def initialize(tag_group_names)
      # "refine" narrows our results by the tags in a tag group.
      # We assume we just get arrays of strings which are
      # the names of the tags in the groups
      groups = tag_group_names.map{|x| self.get_groups x }
      # Now we find all images with those tag groups
      @images = self.refine_groups(groups)
      puts @images.inspect
      puts "So dems the images"
      return @images
    end
    attr_reader :images
    def get_groups(tag_group)
      
      # Basically:
      #   Get all TagGroups where the tags have the given names
      groups = TagGroup.joins(:tags).where(tags: {name: tag_group})
      puts "TagGroups: #{groups.inspect}"
      return groups
    end
    def refine_groups(groups)
      images = Image.all
      groups.each do |x|
        puts "On this loop, images is #{images.inspect}"
        images.where(id: x.pluck(:image_id))
        puts "Refined that down, looping...\n"
      end
      return images
    end
  end
end


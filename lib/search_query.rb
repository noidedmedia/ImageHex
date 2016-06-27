# frozen_string_literal: true
# TODO: Comment this file.
class SearchQuery
  def initialize(q)
    @q = convert_to_hash(q)
  end

  def convert_to_hash(obj)
    case obj
    when NilClass
      {}
    when String
      JSON.parse(obj)
    when ActionController::Parameters, Hash
      obj
    else
      fail TypeError, "must be a hashlike object"
    end
  end

  def each_group(&_block)
    raise ArgumentError("Must take a block") unless block_given?
    return unless @q["tag_groups"]
    tag_groups.each do |group|
      yield group
    end
  end

  def tag_groups
    if @q["tag_groups"].is_a? Array
      @q["tag_groups"]
    else
      @q["tag_groups"].values
    end
  end

  def each_group_tag_ids(&_block)
    raise ArgumentError("Must take a block") unless block_given?
    each_group do |g|
      yield tags(g).map { |t| t["id"] }
    end
  end

  def tags(g)
    g["tags"].is_a?(Hash) ? g["tags"].values : g["tags"]
  end

  def to_h
    @q
  end

  def to_page_h
    return {query: {tag_groups: []}} unless tag_groups
    ar = tag_groups.map do |t|
      {
        tags: tags(t)
      }
    end
    {query: {tag_groups: ar}}
    
  end

  private

  def fix_tag_group_array!
    # $.param is a bit weird, and will turn tag_groups into a hash
    # where the key is a string version of the array index as opposed to
    # an array. So we just flatten to an array
    @q["tag_groups"] = @q["tag_groups"].values if @q["tag_groups"].is_a? Hash
  end
end

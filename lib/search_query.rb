class SearchQuery
  def initialize(q)
    @q = q.nil? ? {} : (q.is_a?(Hash) ? q : JSON.parse(q))
  end

  def each_group(&_block)
    fail ArgumentError("Must take a block") unless block_given?
    return unless @q["tag_groups"]
    @q["tag_groups"].each do |group|
      yield group
    end
  end

  def each_group_tag_ids(&_block)
    fail ArgumentError("Must take a block") unless block_given?
    each_group do |g|
      yield g["tags"].map { |t| t["id"] }
    end
  end

  def to_h
    @q
  end

  def to_page_h
    { query: to_h }
  end

  private

  def fix_tag_group_array!
    # $.param is a bit weird, and will turn tag_groups into a hash
    # where the key is a string version of the array index as opposed to
    # an array. So we just flatten to an array
    @q["tag_groups"] = @q["tag_groups"].values if @q["tag_groups"].is_a? Hash
  end
end

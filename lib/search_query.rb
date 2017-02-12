# frozen_string_literal: true
# TODO: Comment this file.
require 'set'

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
    val = @q["tag_groups"]
    case val
    when Array
      val
    when NilClass
      []
    else
      val.values
    end
  end

  def to_h
    @q
  end

  def groups
    @q["tag_groups"].try(:values) || []
  end

  def to_page_h
    set = Set.new
    hash = Hash.new
    hash["groups"] = self.groups
    self.groups.each do |g|
      g.each{|t| set << t}
    end
    tags = Tag.where(id: set.to_a).to_a.inject({}) do |memo, tag|
      memo[tag.id] = tag.name
      memo
    end
    hash["tags"] = tags
    hash
  end
end

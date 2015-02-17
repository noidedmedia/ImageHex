module ImagesHelper
  def collection_select(u)
    # The options for a user's select
    t = u.collections
      .group_by{|c| c.type}
      .map{|key, value| [key, value.map{|x| [x.name, x.id]}]}
    # transform a user's collections into
    # [type, [name, id]]
    puts t.inspect
    t
  end
end

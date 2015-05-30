class ImageSearchResults
  def initialize(arel)
    @arel = arel
  end
  def paginate(page:, per_page: 10)
    Image.paginate_by_sql(@arel.to_sql, page: page, per_page: per_page)
  end
end

class Utils::Paginator
  attr_reader :params, :list

  def initialize(pictures, params)
    @list = pictures
    @params = params
  end

  def as_json
    {
      key => list_json,
      pages: pages,
      page: page_param
    }
  end

  private

  def list_json
    ordered_list.as_json
  end

  def ordered_list
    paginated_list
  end

  def paginated_list
    limited_list.offset(offset)
  end

  def limited_list
    (per_page > 0) ? list.limit(per_page) : list
  end

  def pages
    (list.count * 1.0 / per_page).ceil
  end

  def offset
    (page_param - 1) * per_page
  end

  def page_param
    [params[:page].to_i, 1].max
  end

  def per_page
    @per_page ||= (params[:per_page] || 8).to_i
  end
end

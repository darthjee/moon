class Utils::Paginator
  attr_reader :params, :list

  delegate :count, :empty?, to: :ordered_list

  def initialize(list, params)
    @list = list
    @params = params
  end

  def as_json
    {
      key => list_json,
      pages: pages,
      page: page_param
    }
  end

  def next_page_offset
    offset + list_json.length - params[:offset].to_i
  end

  def full_page?
    list_json.size == per_page
  end

  private

  def list_json
    @list_json ||= ordered_list.as_json
  end

  def ordered_list
    paginated_list
  end

  def paginated_list
    limited_list.offset(offset)
  end

  def limited_list
    @limited_list ||= fetch_limited_list
  end

  def fetch_limited_list
    list.limit(limit)
  end

  def limit
    return per_page if calculated_offset >= 0
    [ calculated_offset + per_page, 0 ].max
  end

  def pages
    (list.count * 1.0 / per_page).ceil
  end

  def offset
    @offset ||= [calculated_offset, 0].max
  end

  def calculated_offset
    (page_param - 1) * per_page + offset_param
  end

  def offset_param
    params[:offset].to_i
  end

  def page_param
    [params[:page].to_i, 1].max
  end

  def per_page
    @per_page ||= fetch_per_page
  end

  def fetch_per_page
    value = [params[:per_page], 8].compact.first.to_i
    value == 0 ? list.count : value
  end
end

class Marriage::Gift::Paginator
  attr_reader :params, :marriage

  def initialize(marriage, params)
    @marriage = marriage
    @params = params
  end

  def as_json
    {
      gifts: list_json,
      pages: pages,
      page: page_param
    }
  end

  private

  def order_by
    case params[:sort_by]
    when 'price'
      sort_desc? ? :max_price : :min_price
    else
      :name
    end
  end

  def sort_desc?
    sort_direction == 'desc'
  end

  def sort_direction
    params[:sort_direction].present? ? params[:sort_direction] : :asc
  end

  def list_json
    ordered_list.as_json
  end

  def ordered_list
    paginated_list.order(order_by => sort_direction.to_sym).order(name: :asc)
  end

  def paginated_list
    list.limit(per_page).offset(offset)
  end

  def list
    marriage.gifts.not_hidden
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
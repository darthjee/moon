class Marriage::Gift::Paginator < Utils::Paginator
  private

  def key
    :gifts
  end

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

  def ordered_list
    paginated_list.order(order_by => sort_direction.to_sym).order(name: :asc)
  end
end

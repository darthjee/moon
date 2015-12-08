class Helpers::Marriage::GiftQuery
  attr_reader :params, :marriage

  def initialize(marriage, params)
    @marriage = marriage
    @params = params
  end

  def as_json
    {
      gifts: gifts_json,
      pages: gift_pages,
      page: page_param
    }
  end

  private

  def gifts_json
    gifts.as_json(include: :gift_links)
  end

  def gifts
    marriage.gifts.limit(per_page).offset(offset)
  end

  def gift_pages
    (marriage.gifts.count * 1.0 / per_page).ceil
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
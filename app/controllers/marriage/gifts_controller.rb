class Marriage::GiftsController < ApplicationController
  include Marriage::Common

  def index
    respond_to do |format|
      format.json { render json: gifts_list_json }
      format.html { cached_render :index }
    end
  end

  private

  def gifts_list_json
    {
      gifts: gifts_json,
      pages: gift_pages,
      page: page_param
    }
  end

  def gifts_json
    gifts.as_json(include: :gift_links)
  end

  def gifts
    marriage.gifts.limit(per_page).offset(offset)
  end

  private

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
    @per_page ||= (params[:per_page] || 16).to_i
  end
end

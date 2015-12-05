class Marriage::GiftsController < ApplicationController
  include Marriage::Common

  def index
    respond_to do |format|
      format.json { render json: gifts_list_json }
      format.html { cached_render :index }
    end
  end

  def create
    render json: created_gift_links
  end

  private

  def created_gift_links
    gifts_creation_json.map do |gift_json|
      unless gift_link_exists?(gift_json[:url])
        gift = find_or_create_gift(gift_json)
        store_list.gift_links.create(gift: gift, url: gift_json[:url])
      end
    end.compact
  end

  def find_or_create_gift(gift_json)
    if marriage.gifts.where(name: gift_json[:name]).any?
      marriage.gifts.find_by(name: gift_json[:name])
    else
      marriage.gifts.create(image_url: gift_json[:image_url], name: gift_json[:name])
    end
  end

  def gift_link_exists?(url)
    store_list.gift_links.where(url: url).any?
  end

  def store_list
    @store_list ||= marriage.store_lists.find_by(store_id: store_id)
  end

  def store_id
    params.require(:store_id)
  end

  def gifts_creation_json
    params.require(:gifts)
  end

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

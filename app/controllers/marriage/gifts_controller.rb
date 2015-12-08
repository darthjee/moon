class Marriage::GiftsController < ApplicationController
  include Marriage::Common

  before_action :require_admin, only: :create
  protect_from_forgery except: :create

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
    gifts_creation_json.map do |gift_link_json|
      unless gift_link_exists?(gift_link_json[:url])
        gift = find_or_create_gift(gift_link_json[:gift])
        store_list.gift_links.create(gift_link_json.permit(:url, :price).merge(gift: gift))
      end
    end.compact
  end

  def find_or_create_gift(gift_json)
    if marriage.gifts.where(gift_json.permit(:name)).any?
      marriage.gifts.find_by(gift_json.permit(:name))
    else
      marriage.gifts.create(gift_json.permit(:image_url, :name, :quantity))
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
    params.require(:gift_links)
  end

  def gifts_list_json
    Helpers::Marriage::GiftQuery.new(marriage, params).as_json
  end
end

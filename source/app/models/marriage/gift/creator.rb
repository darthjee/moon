class Marriage::Gift::Creator
  attr_reader :params, :marriage

  def initialize(marriage, params)
    @params = params
    @marriage = marriage
  end

  def create
    gifts_creation_json.map do |gift_link_json|
      create_or_update(gift_link_json)
    end.compact
  end

  private

  def create_or_update(gift_link_json)
    gift = find_or_create_gift(gift_link_json[:gift])
    return unless gift
    gift.update(gift_update_json(gift_link_json[:gift]))
    gift.update_bought

    if gift_link_json[:url] && !gift_link_exists?(gift_link_json[:url])
      gift.add_link(gift_link_json.permit(:url, :price).merge(store_list: store_list))
      gift.update_prices
      gift.as_json
    end
  end

  def find_or_create_gift(gift_json)
    find(gift_json, :name) || find(gift_json, :image_url) || create_gift(gift_json)
  end

  def create_gift(gift_json)
    marriage.gifts.create(gift_creation_json(gift_json))
  end

  def find(gift_json, key)
    Marriage::Gift.unscoped.where(marriage: marriage).find_by(gift_json.permit(key))
  end

  def gift_update_json(gift_json)
    gift_json.permit(:bought)
  end

  def gift_creation_json(gift_json)
    gift_json.permit(:image_url, :name, :quantity, :package, :bought).tap do |json|
      json[:package] ||= json[:quantity]
    end
  end

  def gift_link_exists?(url)
    Marriage::GiftLink.unscoped.where(store_list: store_list).where(account_id: nil).where(url: url).any?
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
end

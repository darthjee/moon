class Marriage::Gift::Creator
  attr_reader :params, :marriage

  def initialize(marriage, params)
    @params = params
    @marriage = marriage
  end

  def create
    gifts_creation_json.map do |gift_link_json|
      unless gift_link_exists?(gift_link_json[:url])
        gift = find_or_create_gift(gift_link_json[:gift])
        gift.add_link(gift_link_json.permit(:url, :price).merge(store_list: store_list))
        gift.as_json
      end
    end.compact
  end

  private

  def find_or_create_gift(gift_json)
    if marriage.gifts.where(gift_json.permit(:name)).any?
      marriage.gifts.find_by(gift_json.permit(:name))
    else
      marriage.gifts.create(gift_creation_json(gift_json))
    end
  end

  def gift_creation_json(gift_json)
    gift_json.permit(:image_url, :name, :quantity, :package).tap do |json|
      json[:package] ||= json[:quantity]
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
class Marriage::Gift < ActiveRecord::Base
  has_many :gift_links
  belongs_to :marriage

  def as_json(*args)
    super(*args).merge(
      gift_links: gift_links.map(&:as_json),
      price_range: [min_link_price, max_link_price].uniq.compact
    )
  end

  def price_list
    gift_links.map(&:price).push(price).compact
  end

  def min_link_price
    price_list.min
  end

  def max_link_price
    price_list.max
  end
end

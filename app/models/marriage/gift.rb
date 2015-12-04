class Marriage::Gift < ActiveRecord::Base
  has_many :gift_links
  belongs_to :marriage

  def as_json(*args)
    super(*args).merge(
      gift_links: gift_links.map(&:as_json),
      price_range: [min_price, max_price].uniq.compact
    )
  end

  def min_price
    gift_links.map(&:price).min
  end

  def max_price
    gift_links.map(&:price).max
  end
end

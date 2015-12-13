class Marriage::Gift < ActiveRecord::Base
  has_many :gift_links
  belongs_to :marriage

  scope :not_hidden, -> { where.not(status: :hidden) }

  default_scope do
    where.not(status: :canceled)
  end

  def as_json(*args)
    super(*args).merge(
      gift_links: gift_links.not_hidden.map(&:as_json),
      price_range: [min_price, max_price].uniq.compact,
      packages_quantity: packages_quantity
    )
  end

  def packages_quantity
    (1.0 * quantity / package).ceil
  end

  def price_list
    gift_links.map(&:price)
  end

  def min_link_price
    price_list.min
  end

  def max_link_price
    price_list.max
  end

  def add_link(attributes)
    gift_links.create(attributes)
    update_prices
  end

  def update_prices
    update(
      min_price: min_link_price.to_f * package,
      max_price: max_link_price.to_f * package
    )
  end
end

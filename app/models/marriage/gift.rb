class Marriage::Gift < ActiveRecord::Base
  has_many :gift_links
  belongs_to :marriage
  belongs_to :thread, class_name: 'Comment::Thread'

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

  def cancel
    update(status: :canceled)
    gift_links.each(&:cancel)
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

  def update_bought(bought = nil)
    update(bought: bought) if bought

    if self.bought == self.quantity
      update(status: :bought)
    end
  end

  def update_prices(price = nil)
    gift_links.update_all(price: price) if price

    update(
      min_price: min_link_price.to_f * package,
      max_price: max_link_price.to_f * package
    )
  end
end

class Marriage::Gift < ActiveRecord::Base
  has_many :gift_links
  belongs_to :marriage

  def as_json(*args)
    super(*args).merge(gift_links: gift_links.map(&:as_json))
  end
end

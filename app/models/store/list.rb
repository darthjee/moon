class Marriage::StoreList < ActiveRecord::Base
  belongs_to :marriage
  belongs_to :store
  has_many :gift_links
end

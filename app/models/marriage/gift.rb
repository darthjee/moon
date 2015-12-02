class Marriage::Gift < ActiveRecord::Base
  has_many :gift_links
  belongs_to :marriage
end

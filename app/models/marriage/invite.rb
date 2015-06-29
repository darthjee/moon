class Marriage::Invite < ActiveRecord::Base
  belongs_to :marriage
  has_many :guests
end
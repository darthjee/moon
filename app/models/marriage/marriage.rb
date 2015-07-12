class Marriage::Marriage < ActiveRecord::Base
  has_many :events
  has_many :invites
  has_many :guests
end

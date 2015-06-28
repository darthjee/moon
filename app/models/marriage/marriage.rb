class Marriage::Marriage < ActiveRecord::Base
  has_many :events
  has_many :invites
end
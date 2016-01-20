class Marriage::Album < ActiveRecord::Base
  belongs_to :marriage
  has_many :pictures
end
class Marriage::Guest < ActiveRecord::Base
  belongs_to :invite
  belongs_to :marriage
end

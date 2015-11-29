class Marriage::StoreList < ActiveRecord::Base
  belongs_to :marriage
  belongs_to :store
end

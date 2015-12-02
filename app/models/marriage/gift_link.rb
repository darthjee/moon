class Marriage::GiftLink < ActiveRecord::Base
  belongs_to :gift
  belongs_to :store_list
end

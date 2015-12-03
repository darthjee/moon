class Marriage::GiftLink < ActiveRecord::Base
  belongs_to :gift
  belongs_to :store_list

  def store_image_url
    store_list.store.image_url
  end

  def as_json(*args)
    super(*args).merge(store_image_url: store_image_url)
  end
end

class Marriage::GiftLink < ActiveRecord::Base
  belongs_to :gift
  belongs_to :store_list
  delegate :store, to: :store_list

  def as_json(*args)
    super(*args).merge(
      store: store.as_json(only: [:image_url, :name, :bg_color])
    )
  end
end

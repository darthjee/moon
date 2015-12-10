class Marriage::GiftLink < ActiveRecord::Base
  belongs_to :gift
  belongs_to :store_list
  belongs_to :account, class_name: 'Bank::Account'

  def as_json(*args)
    super(*args).merge(
      store: store.as_json(only: [:image_url, :name, :bg_color])
    )
  end

  def url
    account ? 'url' : super
  end

  def store
    account ? account.bank : store_list.store
  end
end

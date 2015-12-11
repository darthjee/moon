class Marriage::GiftLink < ActiveRecord::Base
  belongs_to :gift
  belongs_to :store_list, class_name: 'Store::List', foreign_key: :store_list_id
  belongs_to :account, class_name: 'Bank::Account'

  def as_json(*args)
    super(*args).merge(
      store: store.as_json(only: [:image_url, :name, :bg_color]),
      bank: bank.as_json(only: [:image_url, :name, :bg_color])
    )
  end

  def store
    store_list.try(:store)
  end

  def bank
    account.try(:bank)
  end
end

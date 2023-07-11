# frozen_string_literal: true

module Marriage
  class GiftLink < ApplicationRecord
    belongs_to :gift
    belongs_to :account, class_name: 'Bank::Account'
    belongs_to :store_list,
               class_name: 'Store::List',
               foreign_key: :store_list_id

    scope(:not_hidden, -> { where.not(status: :hidden) })

    default_scope do
      where.not(status: :canceled)
    end

    def as_json(*args)
      super(*args).merge(
        store: store.as_json(only: %i[image_url name bg_color]),
        bank: bank.as_json(only: %i[image_url name bg_color]),
        account: account.as_json
      )
    end

    def store
      store_list.try(:store)
    end

    def bank
      account.try(:bank)
    end

    def cancel
      update(status: :canceled)
    end
  end
end

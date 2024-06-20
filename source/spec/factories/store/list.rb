# frozen_string_literal: true

FactoryBot.define do
  factory :store_list, class: Store::List do
    store
    marriage
    url { 'http://store.com/list/1' }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :gift_link, class: Marriage::GiftLink do
    gift
    store_list
    url   { 'http://store.com/prod/1' }
    price { 10.0 }

    trait :with_account do
      account
      url        { nil }
      store_list { nil }
    end
  end
end

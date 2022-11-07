# frozen_string_literal: true

FactoryGirl.define do
  factory :gift_link, class: Marriage::GiftLink do
    gift
    store_list
    url 'http://store.com/prod/1'
    price 10.0
  end
end

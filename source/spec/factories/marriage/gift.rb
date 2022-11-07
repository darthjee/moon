# frozen_string_literal: true

FactoryGirl.define do
  factory :gift, class: Marriage::Gift do
    sequence(:name) { |n| 'The Gift %04d' % n }
    image_url 'http://store.com/gifts/images/gift.gif'
    description 'The awesome gift'
    marriage
    quantity 2
  end
end

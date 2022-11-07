# frozen_string_literal: true

FactoryGirl.define do
  factory :store, class: Store::Store do
    name 'The Store'
    image_url 'http://store.com/logo.gif'
    url 'http://store.com'
    bg_color '#fff'
  end
end

# frozen_string_literal: true

FactoryGirl.define do
  factory :album, class: Marriage::Album do
    name 'The pictures'
    marriage
  end
end

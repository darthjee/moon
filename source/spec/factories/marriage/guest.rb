# frozen_string_literal: true

FactoryGirl.define do
  factory :guest, class: Marriage::Guest do
    name 'The Guest'
    presence true
    active true
  end
end

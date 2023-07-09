# frozen_string_literal: true

FactoryBot.define do
  factory :guest, class: Marriage::Guest do
    name     { 'The Guest' }
    presence { true }
    active   { true }
  end
end

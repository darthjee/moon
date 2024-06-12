# frozen_string_literal: true

FactoryBot.define do
  factory :marriage, class: Marriage::Marriage do
    sequence(:display_name) { |n| format('Marriage - %04d', n) }
  end
end

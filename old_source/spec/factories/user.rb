# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    sequence(:code) { |n| format('%04d', n) }
    sequence(:authentication_token) { |n| format('%016d', n) }
  end
end

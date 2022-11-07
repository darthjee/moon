# frozen_string_literal: true

FactoryGirl.define do
  factory :invite, class: Marriage::Invite do
    sequence(:code) { |n| format('%04d', n) }
    sequence(:authentication_token) { |n| format('%016d', n) }
  end
end

FactoryGirl.define do
  factory :invite, class: Marriage::Invite do
    sequence(:code) { |n| '%04d' % n }
    sequence(:authentication_token) { |n| '%016d' % n }
  end
end

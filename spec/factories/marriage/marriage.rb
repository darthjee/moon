FactoryGirl.define do
  factory :marriage, class: Marriage::Marriage do
    sequence(:display_name) { |n| 'Marriage - %04d' % n }
  end
end

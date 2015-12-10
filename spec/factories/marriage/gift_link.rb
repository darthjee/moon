FactoryGirl.define do
  factory :gift_link, class: Marriage::GiftLink do
    gift
    store_list
    price 10.0
  end
end

FactoryGirl.define do
  factory :gift, class: Marriage::Gift do
    name 'The Gift'
    image_url 'http://store.com/gifts/images/gift.gif'
    description 'The awesome gift'
    marriage
    quantity 2
  end
end

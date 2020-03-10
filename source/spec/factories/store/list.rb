FactoryGirl.define do
  factory :store_list, class: Store::List do
    store
    marriage
    url 'http://store.com/list/1'
  end
end

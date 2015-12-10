FactoryGirl.define do
  factory :store_list, class: Marriage::StoreList do
    store
    marriage
    url 'http://store.com/list/1'
  end
end

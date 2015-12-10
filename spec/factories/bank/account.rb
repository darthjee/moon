FactoryGirl.define do
  factory :account, class: Bank::Account do
    bank
    marriage
    agency '007'
    number '001'
  end
end

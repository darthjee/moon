FactoryGirl.define do
  factory :bank, class: Bank::Bank do
    name 'bank name'
    image_url 'http://bank.com/image.png'
  end
end

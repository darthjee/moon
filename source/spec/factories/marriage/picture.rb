FactoryGirl.define do
  factory :picture, class: Marriage::Picture do
    sequence(:name) { |n| "Pic #{n}" }
    album
    sequence(:url) { |n| "http://img#{n}.jpg" }
    sequence(:snap_url) { |n| "http://snap_img#{n}.jpg" }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :marriage_gift_update, class: Hash do
    skip_create

    initialize_with do
      {
        store_id: store.id,
        gift_links: gift_links_json
      }.as_json
    end

    transient do
      marriage   { create(:marriage) }
      store      { create(:store) }

      gift_links { build_list(:gift_link, gift_links_count) }
      gift_links_count { 1 }
      bought { 4 }
      gift_links_json do
        gift_links.map do |gift_link|
          {
            gift: {
              name: gift_link.gift.name,
              bought: bought
            }
          }
        end
      end
    end
  end
end

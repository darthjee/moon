require 'spec_helper'

describe Marriage::Gift do
  describe '#cancel' do
    let(:gift) { marriage_gifts(:first_gift) }
    let(:gift_links_ids) { gift.gift_links.pluck(:id) }

    it do
      expect do
        gift.cancel
      end.to change { Marriage::GiftLink.where(id: gift_links_ids).count }
    end

    it 'clears the links as well' do
      gift.cancel
      gift.reload
      expect(gift.gift_links).to be_empty
    end
  end
end
require 'spec_helper'

describe Marriage::GiftLink do
  describe '#store' do
    context 'when link has an account' do
      let(:subject) { marriage_gift_links(:link_with_account) }
      let(:account) { bank_accounts(:first_account) }

      it 'returns the account' do
        expect(subject.store).to eq(account)
      end
    end

    context 'when link does not have an account' do
      let(:subject) { marriage_gift_links(:first_link) }
      let(:store) { marriage_stores(:first_store) }

      it 'returns the store' do
        expect(subject.store).to eq(store)
      end
    end
  end

  describe '#as_json' do
    let(:link_with_account) { build(:gift_link, account: build(:account)) }
    let(:link_with_store) { build(:gift_link) }

    it 'returns the same structure for store and account link' do
      expect(link_with_account.as_json[:store]).to eq(link_with_store.as_json[:store])
    end
  end
end

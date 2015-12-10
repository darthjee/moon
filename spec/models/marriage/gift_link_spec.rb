require 'spec_helper'

describe Marriage::GiftLink do
  describe '#store' do
    context 'when link has an account' do
      let(:subject) { marriage_gift_links(:link_with_account) }
      let(:bank) { bank_banks(:first_bank) }

      it 'returns the account' do
        expect(subject.store).to eq(bank)
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
    let(:account) { build(:account) }
    let(:store) { store_list.store }
    let(:store_list) { build(:store_list) }
    let(:link_with_account) { build(:gift_link, account: account) }
    let(:link_with_store) { build(:gift_link, store_list: store_list) }

    it 'returns the same structure for store and account link' do
      expect(link_with_account.as_json[:store].keys).to eq(link_with_store.as_json[:store].keys)
    end

    it 'returns the diffrent_jsons for store and account link' do
      expect(link_with_account.as_json[:store]).not_to eq(link_with_store.as_json[:store])
    end

    context 'when it is a store link' do
      it 'returns link url' do
        expect(link_with_store.as_json['url']).to eq('http://store.com/prod/1')
      end
    end

    context 'when it is an account link' do
      it 'returns link url' do
        expect(link_with_account.as_json['url']).to eq('url')
      end
    end
  end
end

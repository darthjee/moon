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
end

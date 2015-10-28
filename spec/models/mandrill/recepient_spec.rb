require 'spec_helper'

describe Mandrill::Recepient do
  let(:email) { 'user@server.com' }
  let(:subject) { described_class.new(email) }

  describe '#as_json' do
    it 'returns the formatted json' do
      expect(subject.as_json.symbolize_keys).to eq(email: email)
    end
  end

  describe '#allowed?' do
    context 'when regexp allows e-mail' do
      it do
        expect(subject.allowed?).to be_truthy
      end
    end

    context 'when regexp do not allow e-mail' do
      before do
        Mandrill.config = Mandrill::Config.new(allowed_emails: /^wrong$/)
      end

      it do
        expect(subject.allowed?).to be_falsey
      end
    end
  end
end
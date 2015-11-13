require 'spec_helper'

describe Mandrill::Recepient do
  let(:email) { 'user@server.com' }
  let(:name) { 'User Name' }
  let(:attributes) { { email: email, name: name } }
  let(:subject) { described_class.new(attributes) }

  describe '#as_json' do
    let(:expected) { { name: name, email: email } }

    it 'returns the formatted json' do
      expect(subject.as_json.symbolize_keys).to eq(expected)
    end

    context 'when initializating with an OpenStruct' do
      let(:attributes) { RecursiveOpenStruct.new( email: email, name: name ) }

      it 'returns the formatted json' do
        expect(subject.as_json.symbolize_keys).to eq(expected)
      end
    end
  end

  describe '#allowed?' do
    context 'when regexp allows e-mail' do
      it do
        expect(subject.allowed?).to be_truthy
      end
    end

    context 'when regexp do not allow e-mail' do
      include_context 'email is not allowed'

      it do
        expect(subject.allowed?).to be_falsey
      end
    end
  end
end
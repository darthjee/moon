require 'spec_helper'

describe Mandrill::Request do
  let(:fixture) { load_json_fixture_file('jsons/mandrill/request.json') }
  let(:subject) { described_class.new(messages, settings) }
  let(:settings) { {} }
  let(:email) { 'user@server.com' }
  let(:messages) { [message] }
  let(:message) { fixture['input'] }

  describe '#as_json' do
    let(:expected) { fixture['output'] }

    it 'returns mandrill formatted message' do
      expect(subject.as_json.deep_stringify_keys).to eq(expected)
    end
  end

  describe '#recepients' do
    context 'when email is allowed' do
      it 'returns mandrill formatted message' do
        expect(subject.recepients.map(&:symbolize_keys)).to eq([{ email: email }])
      end
    end

    context 'when email is not allowed' do
      include_context 'email is not allowed'

      it 'returns mandrill formatted message' do
        expect(subject.recepients).to eq([])
      end
    end
  end

  describe '#has_recepients?' do
    context 'when email is allowed' do
      it 'returns mandrill formatted message' do
        expect(subject.has_recepients?).to be_truthy
      end
    end

    context 'when email is not allowed' do
      include_context 'email is not allowed'

      it 'returns mandrill formatted message' do
        expect(subject.has_recepients?).to be_falsey
      end
    end
  end
end
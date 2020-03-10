require 'spec_helper'

describe Mandrill::Request do
  let(:fixture) { load_json_fixture_file('jsons/mandrill/request.json') }
  let(:subject) { described_class.new(messages, template_key, settings) }
  let(:settings) { {} }
  let(:template_key) { 'template' }
  let(:email) { 'user@server.com' }
  let(:name) { 'User Name' }
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
        expect(subject.recepients.map(&:symbolize_keys)).to eq([{ email: email, name: name }])
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

  describe '#template name' do
    context 'when emails settings do exist' do
      it 'returns emails settings template name' do
        expect(subject.template_name).to eq('mandrill_template')
      end
    end

    context 'when emails settings do not exist' do
      let(:template_key) { 'wrong_template' }
      it do
        expect do
          subject.template_name
        end.to raise_error(Mandrill::Request::NoConfig)
      end
    end
  end
end
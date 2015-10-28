require 'spec_helper'

describe Mandrill::Request do
  let(:subject) { described_class.new(messages, settings) }
  let(:settings) { {} }
  let(:email) { 'user@server.com' }
  let(:messages) { [message] }
  let(:message) do
    {
      recepient: email,
      data: { key1: 'value1' }
    }
  end

  describe '#as_json' do
    let(:expected) do
      {
        headers: { :'Reply-To' => nil},
        return_path_domain: nil,
        to: [{email: 'user@server.com'}],
        merge_vars:[{
          rcpt: 'user@server.com',
          vars: [{ name: 'key1', content: 'value1'}]
        }]
      }
    end

    it 'returns mandrill formatted message' do
      expect(subject.as_json.deep_symbolize_keys).to eq(expected)
    end
  end
end
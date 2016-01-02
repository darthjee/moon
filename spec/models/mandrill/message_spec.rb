require 'spec_helper'

describe Mandrill::Message do
  let(:subject) { described_class.new(attributes) }
  let(:email) { 'user@server.com' }
  let(:name) { 'User Name' }
  let(:attributes) do
    {
      recepient: { name: name, email: email },
      data: { key1: 'value1' }
    }
  end

  describe '#as_json' do
    let(:expected) do
      {
        rcpt: email,
        vars: [{ name: 'KEY1', content: 'value1' }]
      }.deep_stringify_keys
    end

    it 'returns mandrill formatted message' do
      expect(subject.as_json).to eq(expected)
    end
  end
end
require 'spec_helper'

describe Mandrill::Message do
  let(:subject) { described_class.new(attributes) }
  let(:email) { 'user@server.com' }
  let(:attributes) do
    {
      recepient: email,
      data: { key1: 'value1' }
    }
  end

  describe '#as_json' do
    let(:expected) do
      {
        rcpt: email,
        vars: [{ name: 'key1', content: 'value1' }]
      }
    end

    it 'returns mandrill formatted message' do
      expect(subject.as_json).to eq(expected)
    end
  end
end
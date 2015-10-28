require 'spec_helper'

describe Mandrill::Recepient do
  let(:email) { 'user@server.com' }
  let(:subject) { described_class.new(email) }

  describe '#as_json' do
    it 'returns the formatted json' do
      expect(subject.as_json.symbolize_keys).to eq(email: email)
    end
  end
end
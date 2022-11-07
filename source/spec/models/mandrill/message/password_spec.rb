# frozen_string_literal: true

require 'spec_helper'

describe Mandrill::Message::Password do
  let(:user) { User.find(1) }
  let(:root_url) { 'http://teste.com' }
  let(:subject) { described_class.new(user, root_url) }
  let(:email) { 'user@server.com' }
  let(:name) { 'Mr. Test' }

  describe '#as_json' do
    let(:expected) do
      {
        rcpt: email,
        vars: [
          { name: 'NAME', content: name },
          { name: 'ROOT_URL', content: root_url },
          { name: 'TOKEN', content: 'token' },
          { name: 'CODE', content: 'aaaa' }
        ]
      }.deep_stringify_keys
    end

    it 'returns mandrill formatted message' do
      expect(subject.as_json).to eq(expected)
    end
  end
end

require 'spec_helper'

describe Mandrill::Request::Welcome do
  let(:invite) { marriage_invites(:first) }
  let(:name) { invite.guests.first.name }
  let(:user) { User.find(invite.id) }
  let(:subject) { described_class.new(user) }

  describe '#template_name' do
    it do
      expect(subject.template_name).to eq('welcome_template')
    end
  end

  describe '#data' do
    it do
      expect(subject.messages.first.data.as_json).to eq( 'NAME' => name )
    end
  end
end

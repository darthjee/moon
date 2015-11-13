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

  describe '#as_json' do
    let(:vars) { subject.as_json[:merge_vars].first['vars'] }
    let(:expected) do
      [{"name"=>"NAME", "content"=>"Mr. Test"}]
    end

    it 'returns the correct data' do
      expect(vars).to eq(expected)
    end
  end
end

require 'spec_helper'

describe Mandrill::Request::Welcome do
  let(:email) { 'user@srv.com' }
  let(:subject) { described_class.new(email) }

  describe '#template_name' do
    it do
      expect(subject.template_name).to eq('welcome_template')
    end
  end
end

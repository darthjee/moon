# frozen_string_literal: true

require 'spec_helper'

describe Mandrill::Service do
  let(:fixture) { load_json_fixture_file('jsons/mandrill/request.json') }
  let(:subject) { described_class.instance }
  let(:mandrill_messages) { double('mandrill_messages') }
  let(:template_key) { 'template' }
  let(:template_name) { 'mandrill_template' }
  let(:request) { Mandrill::Request.new(fixture['input'], template_key) }

  before do
    allow(Mandrill).to receive(:key) { 'key' }
    allow_any_instance_of(Mandrill::API).to receive(:messages) { mandrill_messages }
    allow(mandrill_messages).to receive(:send_template)
  end

  describe '#send_request' do
    it 'sends to mandrill' do
      expect(mandrill_messages).to receive(:send_template) do |template, template_content, message|
        expect(template).to eq(template_name)
        expect(template_content).to eq([])
        expect(message.deep_stringify_keys).to eq(fixture['output'])
      end
      subject.send_request(request)
    end
  end
end

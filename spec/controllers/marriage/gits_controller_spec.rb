require 'spec_helper'

describe Marriage::GiftsController do
  let(:requests_json) { load_json_fixture_file('requests/marriage/gifts.json') }
  let(:parameters) { requests_json[parameters_key] }
  let(:response_json) { JSON.parse(response.body) }

  describe 'POST create' do
    let(:parameters_key) { 'create' }

    it do
      post :create, parameters
      expect(response).to be_success
    end
  end
end

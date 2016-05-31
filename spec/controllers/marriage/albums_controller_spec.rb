require 'spec_helper'

describe Marriage::AlbumsController do
  describe 'GET index' do
    let(:requests_json) { load_json_fixture_file('requests/marriage/albums.json') }
    let(:marriage) { marriage_marriages(:first) }
    let(:albums) { marriage.albums }
    let(:response_json) { JSON.parse response.body }
    let(:parameters) { requests_json[parameters_key] }
    let(:parameters_key) { 'index' }
    let(:albums_json) { albums.as_json.map(&:stringify_keys) }

    it 'returns all the albums for the given marriage' do
      get :index, parameters
      expect(response_json).to eq({ 'page' => 1, 'pages' => 1, 'albums' => albums_json })
    end
  end
end


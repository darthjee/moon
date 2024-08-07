# frozen_string_literal: true

require 'spec_helper'

describe Marriage::GuestsController do
  let(:requests_json) do
    load_json_fixture_file('requests/marriage/guests.json')
  end
  let(:parameters) { requests_json[parameters_key] }
  let(:response_json) { JSON.parse(response.body) }

  describe 'GET search' do
    let(:parameters_key) { 'search' }
    let(:expected) { [{ id: 1, name: 'Mr. Test' }].map(&:stringify_keys) }

    it 'returns the jsons of the found guests' do
      get :search, params: parameters
      expect(response_json).to eq(expected)
    end

    context 'when names clash with another from another marriage' do
      let(:invite) { marriage_invites(:second_second) }

      before do
        Marriage::Guest.create(
          invite:,
          name: 'Mr. Test'
        )
      end

      it 'returns only from the current marriage' do
        get :search, params: parameters
        expect(response_json.length).to eq(1)
      end
    end

    context 'when searching for part of the name' do
      let(:parameters_key) { 'partial_search' }

      it 'returns all matched guests' do
        get :search, params: parameters
        expect(response_json.length).to eq(4)
      end
    end

    context 'when requesting by the invite label' do
      let(:parameters_key) { 'invite_label_search' }

      it 'returns all matched guests' do
        get :search, params: parameters
        expect(response_json.length).to eq(1)
      end

      it 'returns all matched guests information' do
        get :search, params: parameters
        expect(response_json.first.keys).to eq(%w[code label])
      end
    end
  end
end

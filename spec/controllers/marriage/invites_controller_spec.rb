require 'spec_helper'

describe Marriage::InvitesController do
  let(:requests_json) { load_json_fixture_file('requests/marriage/invites.json')   }
  let(:marriage) { marriage_marriages(:first) }

  describe 'PATCH update' do
    let(:parameters_key) { 'update' }
    let(:parameters) { requests_json[parameters_key] }

    context 'when updating the guests that already exist' do
      it 'changes the presence for the invites' do
        expect do
          patch :update, parameters
        end.to change { marriage.guests.confirmed.count }.by(2)
      end
    end

    context 'when adding guests' do
      let(:parameters_key) { 'update_add' }

      it 'creates a new guest for the marriage' do
        expect do
          patch :update, parameters
        end.to change { marriage.guests.count }.by(1)
      end
    end
  end
end

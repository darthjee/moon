require 'spec_helper'

describe Marriage::InvitesController do
  let(:requests_json) { load_json_fixture_file('requests/marriage/invites.json') }
  let(:marriage) { marriage_marriages(:first) }
  let(:invite) { marriage.invites.first }
  let(:parameters) { requests_json[parameters_key] }

  describe 'PATCH update' do
    let(:parameters_key) { 'update' }

    context 'when updating the guests that already exist' do
      it 'changes the presence for the guests' do
        expect do
          patch :update, parameters
        end.to change { marriage.guests.confirmed.count }.by(2)
      end

      it 'changes the confirmed count for the invite' do
        expect do
          patch :update, parameters
        end.to change { Marriage::Invite.find(invite.id).confirmed }.by(2)
      end

      it 'changes the name of the guests' do
        expect do
          patch :update, parameters
        end.to change { marriage.guests.pluck(:name) }
      end
    end

    context 'when adding guests' do
      let(:parameters_key) { 'update_add' }
      let(:names_expected) do
        ['Mr. Test', 'Mrs. Test', 'Baby Test', 'Junior Test', 'Test Girlfriend']
      end

      it 'creates a new guest for the marriage' do
        expect do
          patch :update, parameters
        end.to change { marriage.guests.count }.by(1)
      end

      it 'creates a new guest for the marriage' do
        patch :update, parameters
        expect(marriage.guests.pluck(:name)).to match_array(names_expected)
      end

      it 'associates the new guests with the invite' do
        patch :update, parameters
        expect(invite.guests.pluck(:name)).to match_array(names_expected)
      end
    end
  end
end

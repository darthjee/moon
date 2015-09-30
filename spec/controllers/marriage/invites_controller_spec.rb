require 'spec_helper'

describe Marriage::InvitesController do
  let(:requests_json) { load_json_fixture_file('requests/marriage/invites.json') }
  let(:marriage) { marriage_marriages(:first) }
  let(:invite) { marriage.invites.first }
  let(:guest) { marriage.invites.first.guests.first }
  let(:parameters) { requests_json[parameters_key] }
  let(:response_json) { JSON.parse(response.body) }

  describe 'GET show' do
    let(:response_json) { JSON.parse response.body }

    shared_examples 'responds with the correct invite' do
      it do
        get :show, parameters
        expect(response).to be_success
      end

      it 'returns the invite' do
        get :show, parameters
        expect(response_json['id']).to eq(invite.id)
        expect(response_json['code']).to eq(invite.code)
      end

      it 'returns the invite guests' do
        get :show, parameters
        expect(response_json).to have_key('guests')
      end

      it do
        expect do
          get :show, parameters
        end.to change { Marriage::Invite.find(invite.id).last_view_date }
      end
    end

    context 'when requesting for an existing invite by code' do
      let(:parameters) { { code: invite.code, format: :json } }

      it_behaves_like 'responds with the correct invite'
    end

    context 'when requesting for an existing invite by guest id ' do
      let(:parameters) { { guest_id: guest.id, format: :json } }

      it_behaves_like 'responds with the correct invite'
    end
  end

  describe 'PATCH update' do
    let(:parameters_key) { 'update' }

    context 'when updating the guests that already exist' do
      it 'changes the presence for the guests' do
        expect do
          patch :update, parameters
        end.to change { invite.guests.confirmed.count }.by(2)
      end

      it 'changes the confirmed count for the invite' do
        expect do
          patch :update, parameters
        end.to change { Marriage::Invite.find(invite.id).confirmed }.by(2)
      end

      it 'changes the name of the guests' do
        expect do
          patch :update, parameters
        end.to change { invite.guests.pluck(:name) }
      end

      it 'updates the invite email' do
        expect do
          patch :update, parameters
        end.to change{ Marriage::Invite.find(invite.id).email }.to('new_user@server.com')
      end

      it 'does not return error' do
        patch :update, parameters

        expect(response_json).not_to have_key('errors')
      end
    end

    context 'when sending an invalid e-mail' do
      let(:parameters_key) { 'update_wrong_email' }

      it 'does not update the e-mail' do
        expect do
          patch :update, parameters
        end.not_to change{ Marriage::Invite.find(invite.id).email }
      end

      it 'does not change the confirmed count for the invite' do
        expect do
          patch :update, parameters
        end.not_to change { Marriage::Invite.find(invite.id).confirmed }
      end

      it 'does not change any guest' do
        expect do
          patch :update, parameters
        end.not_to change { Marriage::Guest.find(guest.id).name }
      end

      it 'does not create new guests' do
        expect do
          patch :update, parameters
        end.not_to change { Marriage::Guest.where(invite_id: invite.id).count }
      end

      it 'returns error' do
        patch :update, parameters

        expect(response_json).to have_key('errors')
        expect(response_json['errors']).to have_key('email')
      end

      it do
        patch :update, parameters
        expect(response).not_to be_success
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
        end.to change { invite.guests.count }.by(1)
      end

      it 'creates a new guest for the marriage' do
        patch :update, parameters
        expect(invite.guests.pluck(:name)).to match_array(names_expected)
      end

      it 'associates the new guests with the invite' do
        patch :update, parameters
        expect(invite.guests.pluck(:name)).to match_array(names_expected)
      end
    end
  end

  describe 'GET cards' do
    it do
      get :cards
      expect(response).not_to be_a_redirect
    end
  end
end

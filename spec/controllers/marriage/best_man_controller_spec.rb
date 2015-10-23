require 'spec_helper'

describe Marriage::BestManController do
  let(:response_json) { JSON.parse response.body }

  describe 'GET index' do
    let(:user) { marriage_invites(:first) }
    let(:invite) { user }
    let(:parameters) { { format: format } }

    context 'When user is logged' do
      before do
        cookies.signed[:credentials] = user.authentication_token
      end

      context 'when requesting for json' do
        let(:format) { :json }

        it 'returns the user invite' do
          get :index, parameters
          expect(response_json['id']).to eq(invite.id)
        end

        it 'returns the user with the guests' do
          get :index, parameters
          expect(response_json).to include('guests')
        end
      end
    end

    context 'When user is not logged' do
      before do
        cookies.delete(:credentials)
      end

      context 'when requesting for json' do
        let(:format) { :json }

        it do
          get :index, parameters
          expect(response.status).to eq(404)
        end
      end
    end
  end

  describe 'GET show_maids' do
    let(:parameters) do
      {
        format: :json,
        role: role
      }
    end
    let(:marriage) { marriage_marriages(:first) }
    before do
      Marriage::Guest.update_all(role: nil)
      marriage.invites.each do |invite|
        create(:guest, role: 'maid_honor', invite: invite)
      end
      create(:guest, role: 'best_man', invite: marriage.invites.first)
      2.times { create(:guest, role: 'mother', invite: marriage.invites.first) }
    end

    context 'when requesting the maids' do
      let(:role) { 'maid_honor' }

      it 'returns all the maids' do
        get :show_maids, parameters
        expect(response_json.map { |g| g['role'] }).to eq(marriage.invites.count.times.map { role })
      end
    end

    context 'when requesting the best_man' do
      let(:role) { 'best_man' }

      it 'returns all the best_man' do
        get :show_maids, parameters
        expect(response_json.map { |g| g['role'] }).to eq([role])
      end
    end

    context 'when requesting the mother' do
      let(:role) { 'mother' }

      it 'returns all the mothers' do
        get :show_maids, parameters
        expect(response_json.map { |g| g['role'] }).to eq([role, role])
      end
    end
  end
end

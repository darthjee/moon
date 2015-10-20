require 'spec_helper'

describe Marriage::BestManController do
  describe 'GET index' do
    let(:user) { marriage_invites(:first) }
    let(:invite) { user }
    let(:parameters) { { format: format } }
    let(:response_json) { JSON.parse response.body }

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
end

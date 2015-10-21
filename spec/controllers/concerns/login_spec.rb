require 'spec_helper'

describe Marriage::Login do
  let(:parameters) { {} }
  controller do
    include Marriage::Login
    skip_redirection :render_root, :index

    def index
      render json: { is_logged: is_logged?, user_id: logged_user.try(:id) }
    end
  end
  let(:response_json) { JSON.parse response.body }
  let(:is_logged) { response_json['is_logged'] }
  let(:logged_id) { response_json['user_id'] }


  describe 'login_from_parameters' do
    let(:user) { marriage_invites(:first) }
    let(:token) { user.authentication_token }

    context 'user is not logged' do
      before { cookies.delete(:credentials) }

      context 'the request contains a token' do
        let(:parameters) { { token: token } }
        before { get :index, parameters }

        it 'logs the user' do
          expect(is_logged).to be_truthy
        end
      end

      context 'the request does not contain a token' do
        before { get :index, parameters }

        it 'does not log the user' do
          expect(is_logged).to be_falsey
        end
      end
    end

    context 'user is already logged as another user' do
      let(:old_user) { marriage_invites(:empty) }

      before do
        cookies.signed[:credentials] = old_user.authentication_token
      end

      context 'the request contains a token' do
        let(:parameters) { { token: token } }
        before { get :index, parameters }

        it 'logs in the user' do
          expect(is_logged).to be_truthy
        end

        it 'changes logged in user' do
          expect(logged_id).to eq(user.id)
        end
      end

      context 'the request does not contain a token' do
        before { get :index, parameters }

        it 'does not change logged in state' do
          expect(is_logged).to be_truthy
        end

        it 'does not change logged in user' do
          expect(logged_id).to eq(old_user.id)
        end
      end
    end
  end
end
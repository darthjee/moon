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
  let(:user) { marriage_invites(:first) }

  describe '#sign_in' do
    context 'when no one is signed in' do
      before do
        cookies.delete(:credentials)
        controller.sign_in(user)
        get :index, parameters
      end

      it 'logs the user' do
        expect(is_logged).to be_truthy
      end

      it 'changes logged in user' do
        expect(logged_id).to eq(user.id)
      end
    end

    context 'when a user is already signed in' do
      let(:old_user) { marriage_invites(:empty) }

      before do
        cookies.signed[:credentials] = old_user.authentication_token
        controller.sign_in(user)
        get :index, parameters
      end

      it 'logs the user' do
        expect(is_logged).to be_truthy
      end

      it 'changes logged in user' do
        expect(logged_id).to eq(user.id)
      end
    end
  end

  describe '#sign_off' do
    context 'when no one is signed in' do
      before do
        cookies.delete(:credentials)
        controller.sign_off
        get :index, parameters
      end

      it 'keeps user logged off' do
        expect(is_logged).to be_falsey
      end

      it 'keeps the user as nil' do
        expect(logged_id).to be_nil
      end
    end

    context 'when a user is already signed in' do
      before do
        cookies.signed[:credentials] = user.authentication_token
        controller.sign_off
        get :index, parameters
      end

      it 'logs off the user' do
        expect(is_logged).to be_falsey
      end

      it 'changes logged in user to nil' do
        expect(logged_id).to be_nil
      end
    end
  end

  describe '#login_from_parameters' do
    let(:token) { user.authentication_token }

    context 'user is not logged' do
      before { cookies.delete(:credentials) }

      context 'the request contains a token' do
        let(:parameters) { { token: token } }
        before { get :index, parameters }

        it 'logs the user' do
          expect(is_logged).to be_truthy
        end

        it 'changes logged in user' do
          expect(logged_id).to eq(user.id)
        end
      end

      context 'the request does not contain a token' do
        before { get :index, parameters }

        it 'does not log the user' do
          expect(is_logged).to be_falsey
        end

        it 'does not change logged in user' do
          expect(logged_id).to be_nil
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

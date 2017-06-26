require 'spec_helper'

describe Marriage::LoginController do
  let(:user) { users(:first) }

  describe 'GET check' do
    context 'User is not logged' do
      it do
        get :check, format: :json
        expect(response).to be_a_not_found
      end

      context 'Because user has the wrong credentials' do
        before do
          cookies.signed[:credentials] = 'wrong'
        end

        it do
          get :check, format: :json
          expect(response).to be_a_not_found
        end
      end

      context 'Because user has a fake credential' do
        before do
          cookies[:credentials] = user.authentication_token
        end

        it do
          get :check, format: :json
          expect(response).to be_a_not_found
        end
      end
    end

    context 'User is logged' do
      before do
        cookies.signed[:credentials] = user.authentication_token
      end

      it do
        get :check, format: :json
        expect(response).to be_a_success
      end
    end
  end

  describe 'POST create' do
    let(:email) { user.email }
    let(:password) { 'pass_code' }
    let(:parameters) do
      {
        login: { email: email, password: password },
        format: :json
      }
    end

    context 'when use has a password' do
      before do
        user.password = 'pass_code'
        user.save
        post :create, params: parameters
      end

      context 'when requesting with correct email and password' do
        it do
          expect(response).to be_a_success
        end

        it 'sets the user as logged' do
          get :check, format: :json
          expect(response).to be_a_success
        end
      end

      context 'when requesting with incorrect email and password' do
        let(:password) { 'wrong pass_code' }

        it do
          expect(response).to be_a_not_found
        end

        it 'do not set the user as logged' do
          get :check, format: :json
          expect(response).to be_a_not_found
        end
      end
    end

    context 'when trying to login with an invite without email or password' do
      let(:email) { nil }
      let(:password) { nil }

      before do
        user.update(password: nil, email: nil)
        post :create, params: parameters
      end

      it do
        expect(response).to be_a_not_found
      end

      it 'do not set the user as logged' do
        get :check, format: :json
        expect(response).to be_a_not_found
      end
    end
  end
end

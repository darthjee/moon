require 'spec_helper'

describe Marriage::LoginController do
  let(:user) { marriage_invites(:first) }

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
end

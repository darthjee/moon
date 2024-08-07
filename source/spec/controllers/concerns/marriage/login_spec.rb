# frozen_string_literal: true

require 'spec_helper'

describe Marriage::Login do
  let(:parameters) { {} }
  let(:response_json) { JSON.parse response.body }
  let(:logged) { response_json['logged'] }
  let(:logged_id) { response_json['user_id'] }
  let(:user) { users(:first) }

  # rubocop:disable RSpec/DescribedClass
  controller(ApplicationController) do
    include Marriage::Login

    def index
      render json: { logged: logged?, user_id: logged_user.try(:id) }
    end
  end
  # rubocop:enable RSpec/DescribedClass

  describe '#sign_in' do
    context 'when no one is signed in' do
      before do
        controller.sign_off
        controller.sign_in(user)
        get :index, params: parameters
      end

      it 'logs the user' do
        expect(logged).to be_truthy
      end

      it 'changes logged in user' do
        expect(logged_id).to eq(user.id)
      end
    end

    context 'when a user is already signed in' do
      let(:old_user) { users(:empty) }

      before do
        controller.sign_in(old_user)
        controller.sign_in(user)
        get :index, params: parameters
      end

      it 'logs the user' do
        expect(logged).to be_truthy
      end

      it 'changes logged in user' do
        expect(logged_id).to eq(user.id)
      end
    end
  end

  describe '#sign_off' do
    context 'when no one is signed in' do
      before do
        controller.sign_off
        get :index, params: parameters
      end

      it 'keeps user logged off' do
        expect(logged).to be_falsey
      end

      it 'keeps the user as nil' do
        expect(logged_id).to be_nil
      end
    end

    context 'when a user is already signed in' do
      before do
        controller.sign_in(user)
        controller.sign_off
        get :index, params: parameters
      end

      it 'logs off the user' do
        expect(logged).to be_falsey
      end

      it 'changes logged in user to nil' do
        expect(logged_id).to be_nil
      end
    end
  end

  describe '#login_from_parameters' do
    let(:token) { user.authentication_token }

    context 'when user is not logged' do
      before { cookies.delete(:credentials) }

      context 'with the request contains a token' do
        let(:parameters) { { token: } }

        before { get :index, params: parameters }

        it 'logs the user' do
          expect(logged).to be_truthy
        end

        it 'changes logged in user' do
          expect(logged_id).to eq(user.id)
        end
      end

      context 'with the request does not contain a token' do
        before { get :index, params: parameters }

        it 'does not log the user' do
          expect(logged).to be_falsey
        end

        it 'does not change logged in user' do
          expect(logged_id).to be_nil
        end
      end
    end

    context 'when user is already logged as another user' do
      let(:old_user) { users(:empty) }

      before do
        cookies.signed[:credentials] = old_user.authentication_token
      end

      context 'with the request contains a token' do
        let(:parameters) { { token: } }

        before { get :index, params: parameters }

        it 'logs in the user' do
          expect(logged).to be_truthy
        end

        it 'changes logged in user' do
          expect(logged_id).to eq(user.id)
        end
      end

      context 'with the request does not contain a token' do
        before { get :index, params: parameters }

        it 'does not change logged in state' do
          expect(logged).to be_truthy
        end

        it 'does not change logged in user' do
          expect(logged_id).to eq(old_user.id)
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe User do

  it_behaves_like 'an object that has a secure random code start up',
                  :code, :authentication_token

  describe '.login' do
    let!(:user)    { create(:user, password: password) }
    let(:password) { 'my_custom_password' }
    let(:login)    { user.login }

    let(:login_hash) do
      {
        login: login,
        password: password
      }
    end

    context 'when login and password matches' do
      it 'returns user' do
        expect(described_class.login(**login_hash)).to eq(user)
      end
    end

    context 'when login matches but not the password' do
      let(:user) { create(:user) }

      it do
        expect { described_class.login(**login_hash) }
          .to raise_error(Moon::Exception::LoginFailed)
      end
    end

    context 'when login does not matches' do
      let(:login) { 'other_login' }

      it do
        expect { described_class.login(**login_hash) }
          .to raise_error(Moon::Exception::LoginFailed)
      end
    end
  end

  describe '.create' do
    let(:user) { build(:user, code: nil, authentication_token: nil) }

    it do
      expect { user.save }.to change(user, :code)
    end

    it do
      expect { user.save }.to change(user, :authentication_token)
    end
  end

  describe 'validations' do
    let(:user) { users(:second_second) }

    context 'when email is nil' do
      it { expect(user).to be_valid }
    end

    context 'when email is not nil' do
      let(:invite) { users(:with_email) }

      context 'and is valid' do
        it { expect(user).to be_valid }
      end

      context 'and is invalid ' do
        before { user.email = 'wrong_email' }

        it { expect(user).to be_invalid }
      end
    end
  end

  describe '#password=' do
    let(:user)     { build(:user) }
    let(:password) { 'my password' }

    it do
      expect { user.password = password }
        .to change(user, :salt)
    end

    it do
      expect { user.password = password }
        .to change(user, :encrypted_password)
    end

    it 'changes encrypted password to an encrypted value' do
      user.password = password
      expect(user.encrypted_password).not_to eq(password)
    end
  end

  describe '#verify_password!' do
    let(:user)     { create(:user, password: password) }
    let(:password) { 'my_custom_password' }

    context 'when password is correct' do
      it 'returns self' do
        expect(user.verify_password!(password)).to eq(user)
      end

      it do
        expect { user.verify_password!(password) }
          .not_to change(user, :salt)
      end
    end

    context 'when password is incorrect' do
      let(:user) { create(:user) }

      it do
        expect { user.verify_password!(password) }
          .to not_change(user, :salt)
          .and raise_error(Moon::Exception::LoginFailed)
      end
    end
  end
end

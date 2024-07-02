# frozen_string_literal: true

require 'spec_helper'

describe User do
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

      context 'and is invalid' do
        before { user.email = 'wrong_email' }

        it { expect(user).to be_invalid }
      end
    end
  end

  it_behaves_like 'an object that has a secure random code start up',
                  :code, :authentication_token

  describe 'create' do
    let(:user) { build(:user, code: nil, authentication_token: nil) }

    it do
      expect { user.save }.to change(user, :code)
    end

    it do
      expect { user.save }.to change(user, :authentication_token)
    end
  end
end

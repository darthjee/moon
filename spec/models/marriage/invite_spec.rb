require 'spec_helper'

describe Marriage::Invite do
  describe 'validations' do
    let(:invite) { marriage_invites(:second_second) }

    context 'when email is nil' do
      it { expect(invite).to be_valid }
    end

    context 'when email is not nil' do
      let(:invite) { marriage_invites(:with_email) }

      context 'and is valid' do
        it { expect(invite).to be_valid }
      end

      context 'and is invalid ' do
        before{ invite.email = 'wrong_email' }

        it { expect(invite).to be_invalid }
      end
    end
  end

  it_behaves_like 'an object that has a secure random code start up', :code, :authentication_token

  describe 'create' do
    let(:marriage) { create(:marriage) }
    let(:invite) { build(:invite, code: nil, authentication_token: nil, marriage_id: marriage.id) }

    it do
      expect { invite.save }.to change(invite, :code)
    end

    it do
      expect { invite.save }.to change(invite, :authentication_token)
    end
  end
end

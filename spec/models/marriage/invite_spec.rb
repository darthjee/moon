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
end

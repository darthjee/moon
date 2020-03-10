require 'spec_helper'

describe Marriage::PasswordsController do
  let(:invite) { marriage_invites(:first) }
  let(:user) { User.for_invite(invite) }

  describe 'POST #create' do
    let(:mandrill_service) { Mandrill::Service.instance }
    let(:parameters) do
      {
        email: user.email,
        format: :json
      }
    end
    let(:message) { Mandrill::Request::Password.new(user, 'http://test.host') }
    before do
      allow(mandrill_service).to receive(:send_request)
    end

    it do
      expect(mandrill_service).to receive(:send_request).with(message)
      post :create, params: parameters
    end
  end
end

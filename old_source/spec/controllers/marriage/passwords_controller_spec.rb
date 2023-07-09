# frozen_string_literal: true

require 'spec_helper'

describe Marriage::PasswordsController do
  let(:invite) { marriage_invites(:first) }
  let(:user) { User.for_invite(invite) }

  describe 'POST #create' do
    let(:parameters) do
      {
        email: user.email,
        format: :json
      }
    end

    xit do
      post :create, params: parameters
    end
  end
end

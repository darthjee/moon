# frozen_string_literal: true

class EnsureInvitesHaveAuthenticationToken < ActiveRecord::Migration[4.2]
  def up
    Marriage::Invite.unscoped.find_each(&:start_authentication_token)
  end

  def down; end
end

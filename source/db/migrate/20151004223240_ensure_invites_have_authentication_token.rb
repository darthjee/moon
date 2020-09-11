class EnsureInvitesHaveAuthenticationToken < ActiveRecord::Migration[4.2]
  def up
    Marriage::Invite.unscoped.find_each do |invite|
      invite.start_authentication_token
    end
  end

  def down
  end
end

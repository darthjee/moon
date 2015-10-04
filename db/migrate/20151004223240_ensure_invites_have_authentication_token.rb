class EnsureInvitesHaveAuthenticationToken < ActiveRecord::Migration
  def up
    Marriage::Invite.all.find_each do |invite|
      invite.start_authentication_token
    end
  end

  def down
  end
end

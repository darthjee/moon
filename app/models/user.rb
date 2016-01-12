class User < ActiveRecord::Base
  has_one :invite, class_name: 'Marriage::Invite', foreign_key: :user_id

  class << self
    def for_invite(invite)
      new(invite: invite)
    end
  end
end
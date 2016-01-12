class User < ActiveRecord::Base
  has_one :invite

  class << self
    def for_invite(invite)
      new(invite: invite)
    end
  end
end
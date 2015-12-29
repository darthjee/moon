class User
  attr_reader :id
  delegate :email, :welcome_sent, :update, to: :invite

  class << self
    def find(id)
      User.new({ id: id })
    end

    def for_invite(invite)
      new(invite: invite)
    end

    def find_by!(*args)
      find Marriage::Invite.find_by!(*args).id
    end
  end

  def initialize(attributes)
    @id = attributes[:id]
    @invite = attributes[:invite]
  end

  def name
    guest.try(:name)
  end

  private

  def invite
    @invite ||= Marriage::Invite.find(id)
  end

  def guest
    invite.guests.first
  end
end
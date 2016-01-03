class User
  attr_reader :id
  delegate :email, :welcome_sent, :update,
           :code, :authentication_token, to: :invite

  class << self
    def find(id)
      User.new({ id: id })
    end

    def for_invite(invite)
      new(invite: invite)
    end

    def find_by!(*args)
      for_invite Marriage::Invite.find_by!(*args)
    end

    def where(*args)
      Marriage::Invite.where(*args).map do |invite|
        for_invite invite
      end
    end
  end

  def initialize(attributes)
    @id = attributes[:id]
    @invite = attributes[:invite]
  end

  def name
    guest.try(:name)
  end

  def as_json
    {
      name: name,
      email: email
    }
  end

  private

  def invite
    @invite ||= Marriage::Invite.find(id)
  end

  def guest
    invite.guests.first
  end
end
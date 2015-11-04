class User
  attr_reader :id
  delegate :name, to: :guest
  delegate :email, to: :invite

  class << self
    def find(id)
      User.new({ id: id })
    end
  end

  def initialize(attributes)
    @id = attributes[:id]
  end

  private

  def invite
    @invite ||= Marriage::Invite.find(id)
  end

  def guest
    invite.guests.first
  end
end
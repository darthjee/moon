class Marriage::Marriage < ActiveRecord::Base
  has_many :events
  has_many :invites

  def guests
    ::Marriage::Guest.joins(:invite).where(marriage_invites: { marriage_id: id })
  end
end

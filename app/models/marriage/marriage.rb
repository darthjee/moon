class Marriage::Marriage < ActiveRecord::Base
  has_many :events
  has_many :invites
  has_many :store_lists

  def guests
    ::Marriage::Guest.joins(:invite).where(marriage_invites: { marriage_id: id })
  end
end

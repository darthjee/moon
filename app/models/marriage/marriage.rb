class Marriage::Marriage < ActiveRecord::Base
  has_many :events
  has_many :invites
  has_many :store_lists, class_name: 'Store::List'
  has_many :gifts
  has_many :accounts, class_name: 'Bank::Account'

  def guests
    ::Marriage::Guest.joins(:invite).where(marriage_invites: { marriage_id: id })
  end
end

# frozen_string_literal: true

module Marriage
  class Marriage < ActiveRecord::Base
    has_many :events
    has_many :invites
    has_many :albums
    has_many :store_lists, class_name: 'Store::List'
    has_many :gifts
    has_many :accounts, class_name: 'Bank::Account'
    has_many :threads, class_name: 'Comment::Thread'

    def guests
      Guest.joins(:invite).where(marriage_invites: { marriage_id: id })
    end
  end
end

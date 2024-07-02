# frozen_string_literal: true

module Marriage
  class Invite < ActiveRecord::Base
    belongs_to :marriage
    has_many :guests
    belongs_to :user, class_name: 'User', optional: true

    validates_associated :user

    scope(:search_label, proc { |label| where('label LIKE ?', "%#{label}%") })
    scope(:created, proc { where(status: :created) })
    default_scope { where.not(status: :cancelled) }

    accepts_nested_attributes_for :user

    # delegate :code, :authentication_token, :email, :name, to: :user
  end
end

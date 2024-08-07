# frozen_string_literal: true

module Marriage
  class Guest < ActiveRecord::Base
    belongs_to :invite
    belongs_to :marriage, optional: true

    scope(:confirmed, proc { where(presence: true) })
    scope(:search_name, proc { |name| where('name LIKE ?', "%#{name}%") })
    default_scope { where(active: true) }
  end
end

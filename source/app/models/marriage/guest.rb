# frozen_string_literal: true

module Marriage
  class Guest < ApplicationRecord
    belongs_to :invite

    scope(:confirmed, proc { where(presence: true) })
    scope(:search_name, proc { |name| where('name LIKE ?', "%#{name}%") })
    default_scope { where(active: true) }
  end
end

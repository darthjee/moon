# frozen_string_literal: true

module Store
  class Store < ApplicationRecord
    has_many :store_lists
  end
end

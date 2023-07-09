# frozen_string_literal: true

module Store
  class Store < ActiveRecord::Base
    has_many :store_lists
  end
end

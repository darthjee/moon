# frozen_string_literal: true

class Store::Store < ActiveRecord::Base
  has_many :store_lists
end

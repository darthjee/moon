# frozen_string_literal: true

module Bank
  class Bank < ApplicationRecord
    has_many :accounts
  end
end

# frozen_string_literal: true

module Bank
  class Bank < ActiveRecord::Base
    has_many :accounts
  end
end

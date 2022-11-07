# frozen_string_literal: true

class Bank::Bank < ActiveRecord::Base
  has_many :accounts
end

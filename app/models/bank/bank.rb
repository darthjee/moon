class Bank::Bank < ActiveRecord::Base
  has_many :accounts
end
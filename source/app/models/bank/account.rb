class Bank::Account < ActiveRecord::Base
  belongs_to :bank
  belongs_to :marriage, class_name: 'Marriage::Marriage'
end

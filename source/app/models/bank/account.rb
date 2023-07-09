# frozen_string_literal: true

module Bank
  class Account < ApplicationRecord
    belongs_to :bank
    belongs_to :marriage, class_name: 'Marriage::Marriage'
  end
end

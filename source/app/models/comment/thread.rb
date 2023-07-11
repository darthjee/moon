# frozen_string_literal: true

module Comment
  class Thread < ApplicationRecord
    has_many :comments
    belongs_to :marriage, class_name: 'Marriage::Marriage'
  end
end

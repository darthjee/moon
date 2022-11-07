# frozen_string_literal: true

class Marriage::Location < ActiveRecord::Base
  belongs_to :marriage
end

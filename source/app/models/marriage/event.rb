# frozen_string_literal: true

class Marriage::Event < ActiveRecord::Base
  belongs_to :marriage
  belongs_to :location
end

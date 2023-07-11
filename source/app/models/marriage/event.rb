# frozen_string_literal: true

module Marriage
  class Event < ApplicationRecord
    belongs_to :marriage
    belongs_to :location
  end
end

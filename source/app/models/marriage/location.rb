# frozen_string_literal: true

module Marriage
  class Location < ApplicationRecord
    belongs_to :marriage
  end
end

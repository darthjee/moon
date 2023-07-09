# frozen_string_literal: true

module Marriage
  class Location < ActiveRecord::Base
    belongs_to :marriage
  end
end

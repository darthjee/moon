# frozen_string_literal: true

class Utils::TimeElapsed
  attr_reader :time, :amount

  TIME_BLOCKS = {
    year: 3600 * 24 * 365,
    day: 3600 * 24,
    hour: 3600,
    minute: 60,
    second: 1
  }.freeze

  def initialize(time)
    @time = time
  end

  def as_json
    calculate_amount

    {
      amount: amount.to_i,
      unit: unit
    }
  end

  private

  def calculate_amount
    @amount ||= Time.now - time
    return if amount.zero?

    @amount /= TIME_BLOCKS[unit]
  end

  def unit
    @unit ||= find_unit || TIME_BLOCKS.keys.last
  end

  def find_unit
    TIME_BLOCKS.map_and_find do |u, size|
      u if (amount / size).to_i > 0
    end
  end
end

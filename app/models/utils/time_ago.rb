class Utils::TimeAgo
  attr_reader :time

  TIME_BLOCKS = {
    year: 3600*24*365,
    day: 3600*24,
    hour: 3600,
    minute: 60,
    second: 1
  }


  def initialize(time)
    @time = time
  end

  def as_json
    @amount = amount / TIME_BLOCKS[unit]

    {
      amount: amount.to_i,
      unit: unit
    }
  end

  private

  def unit
    @unit ||= TIME_BLOCKS.map_and_find do |u, size|
      u if (amount / size).to_i > 0
    end
  end

  def amount
    @amount ||= Time.now - time
  end
end
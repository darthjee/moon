class Utils::TimeAgo
  attr_reader :time

  def initialize(time)
    @time = time
  end

  def as_json
    amount = Time.now - time

    {
      amount: amount.to_i,
      unit: :seconds
    }
  end
end
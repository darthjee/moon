class Mandrill::Message < DelegateClass(RecursiveOpenStruct)
  attr_reader :recepient

  def initialize(message)
    @message = RecursiveOpenStruct.new(message)
    @recepient = Mandrill::Recepient.new(@message.recepient)
    super(@message)
  end

  def as_json(*args)
    {
      rcpt: recepient,
      vars: vars
    }.as_json
  end

  private

  def vars
    data.as_json.map do |key, value|
      { name: key.to_s, content: value }
    end
  end
end
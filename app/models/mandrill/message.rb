class Mandrill::Message < DelegateClass(RecursiveOpenStruct)
  attr_reader :recepient

  def initialize(message)
    @message = RecursiveOpenStruct.new(message)
    @recepient = Mandrill::Recepient.new(@message.recepient)
    super(@message)
  end

  def as_json(*args)
    {
      rcpt: recepient.email,
      vars: vars
    }.as_json
  end

  def self.parse(hash)
    hash.is_a?(Hash) ? new(hash) : hash
  end

  private

  def data_json
    data.as_json
  end

  def vars
    data_json.map do |key, value|
      { name: key.to_s.upcase, content: value }
    end
  end

  require 'mandrill/message/base'
  require 'mandrill/message/access'
  require 'mandrill/message/password'
end

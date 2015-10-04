class EmailValidator::Matcher
  PRELIMINARREGEXP = /^(?<user>.*)@(?<server>.*)$/
  USERREGEXP = /^[a-z]+(([_.][a-z])?[a-z0-9]+)*(\+\w+)*$/
  SERVERREGEXP = /^[\w]+([._]?[a-z0-9]+)*(\.[a-z0-9]{2,3}){1,2}/i
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def match
    return false unless value =~ PRELIMINARREGEXP
    return false unless user =~ USERREGEXP
    server =~ SERVERREGEXP
  end

  private

  def matches
    @matches ||= PRELIMINARREGEXP.match(@value)
  end

  def user
    matches[:user]
  end

  def server
    matches[:server]
  end
end

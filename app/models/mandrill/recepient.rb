require 'mandrill_ext'

class Mandrill::Recepient
  attr_reader :email

  def initialize(email)
    @email = email
  end

  def allowed?
    Mandrill.email_allowed? email
  end
end
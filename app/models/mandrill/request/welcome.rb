class Mandrill::Request::Welcome < Mandrill::Request
  TEMPLATE_KEY = 'welcome'

  def initialize(email)
    super({
      recepient: email,
      data: {}
    }, self.class::TEMPLATE_KEY)
  end
end
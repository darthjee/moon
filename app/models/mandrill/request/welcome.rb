class Mandrill::Request::Welcome < Mandrill::Request
  attr_reader :user
  delegate :name, :email, to: :user

  TEMPLATE_KEY = 'welcome'

  def initialize(user)
    @user = user
    super({
      recepient: { email: email, name: :name },
      data: { NAME: name }
    }, self.class::TEMPLATE_KEY)
  end
end
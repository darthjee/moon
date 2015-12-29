class Mandrill::Request::Welcome < Mandrill::Request
  attr_reader :user
  delegate :name, :email, to: :user

  TEMPLATE_KEY = 'welcome'

  def initialize(user, root_url)
    @user = user
    super({
      recepient: { email: email, name: name },
      data: { name: name, root_url: root_url }
    }, self.class::TEMPLATE_KEY)
  end
end
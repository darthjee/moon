class Mandrill::Request::Base < Mandrill::Request
  attr_reader :user
  delegate :name, :email, to: :user

  def initialize(user, root_url)
    @user = user
    super({
      recepient: { email: email, name: name },
      data: { name: name, root_url: root_url }
    }, self.class::TEMPLATE_KEY)
  end
end
class Mandrill::Request::Base < Mandrill::Request
  attr_reader :user
  delegate :name, :email, to: :user

  def initialize(user, root_url)
    @user = user
    super(Mandrill::Message::Base.new(user, root_url), self.class::TEMPLATE_KEY)
  end
end

class Mandrill::Request::Base < Mandrill::Request
  attr_reader :user, :root_url
  delegate :name, :email, to: :user

  def initialize(user, root_url)
    @user = user
    @root_url = root_url
    super(nil, self.class::TEMPLATE_KEY)
  end

  def messages
    [
      Mandrill::Message::Base.new(user, root_url)
    ]
  end
end

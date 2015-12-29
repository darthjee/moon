class Mandrill::Request::Password < Mandrill::Request::Base
  TEMPLATE_KEY = 'password'

  def messages
    [
      Mandrill::Message::Password.new(user, root_url)
    ]
  end
end
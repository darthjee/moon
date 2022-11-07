# frozen_string_literal: true

require 'mandrill/message'

class Mandrill::Request::HonorUpdate < Mandrill::Request::Base
  TEMPLATE_KEY = 'honor-update'

  def messages
    [
      Mandrill::Message::Access.new(user, root_url)
    ]
  end
end

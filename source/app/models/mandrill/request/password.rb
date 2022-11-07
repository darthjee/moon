# frozen_string_literal: true

require 'mandrill/message'

module Mandrill
  class Request
    class Password < Mandrill::Request::Base
      TEMPLATE_KEY = 'password'

      def messages
        [
          Mandrill::Message::Password.new(user, root_url)
        ]
      end
    end
  end
end

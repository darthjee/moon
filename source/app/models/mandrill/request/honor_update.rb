# frozen_string_literal: true

require 'mandrill/message'

module Mandrill
  class Request
    class HonorUpdate < Mandrill::Request::Base
      TEMPLATE_KEY = 'honor-update'

      def messages
        [
          Mandrill::Message::Access.new(user, root_url)
        ]
      end
    end
  end
end

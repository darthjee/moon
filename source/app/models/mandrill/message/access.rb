# frozen_string_literal: true

module Mandrill
  class Message
    class Access < Mandrill::Message::Base
      private

      def data_json
        super.merge(
          token: user.authentication_token
        )
      end
    end
  end
end

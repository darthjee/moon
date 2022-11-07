# frozen_string_literal: true

module Mandrill
  class Message
    class Password < Mandrill::Message::Access
      private

      def data_json
        super.merge(
          code: user.code
        )
      end
    end
  end
end

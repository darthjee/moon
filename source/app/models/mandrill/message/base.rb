# frozen_string_literal: true

module Mandrill
  class Message
    class Base < Mandrill::Message
      attr_reader :user
      delegate :name, :email, to: :user

      def initialize(user, root_url)
        @user = user

        super(
          recepient: { email: email, name: name },
          data: { name: name, root_url: root_url }
        )
      end
    end
  end
end

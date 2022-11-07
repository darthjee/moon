# frozen_string_literal: true

module Mandrill
  class Request
    class Base < Mandrill::Request
      attr_reader :user, :root_url
      delegate :name, :email, to: :user

      def initialize(user, root_url, settings = {})
        @user = user
        @root_url = root_url
        @settings = settings
      end

      def messages
        [
          Mandrill::Message::Base.new(user, root_url)
        ]
      end

      def template_key
        self.class::TEMPLATE_KEY
      end
    end
  end
end

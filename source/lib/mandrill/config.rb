# frozen_string_literal: true

module Mandrill
  class Config < DelegateClass(RecursiveOpenStruct)
    class << self
      def default_config
        {
          key: ENV['MANDRILL_APP_KEY'],
          allowed_emails: Regexp.new(ENV['MANDRILL_ALLOWED_REGEXP'] || '.*'),
          reply_to: ENV['MANDRILL_REPLY_TO'],
          return_path_domain: ENV['MANDRILL_RETURN_PATH']
        }
      end
    end

    def initialize(config = {})
      @config = RecursiveOpenStruct.new self.class.default_config.merge(config)
      super(@config)
    end
  end
end

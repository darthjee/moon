require 'mandrill'
require 'mandrill/config'

module Mandrill
  class << self
    mattr_accessor :config

    delegate :key, :allowed_emails, :reply_to, :return_path_domain, to: :config

    def email_allowed?(email)
      allowed_emails_regexp.match(email)
    end

    def config
      @config ||= Config.new
    end
  end
end

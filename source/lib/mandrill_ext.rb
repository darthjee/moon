# frozen_string_literal: true

module Mandrill
  class << self
    attr_writer :config

    delegate :key, :allowed_emails, :reply_to, :return_path_domain, to: :config

    def table_name_prefix
      'mandrill_'
    end

    def email_allowed?(email)
      allowed_emails.match(email)
    end

    def config
      @config ||= Config.new
    end
  end
end

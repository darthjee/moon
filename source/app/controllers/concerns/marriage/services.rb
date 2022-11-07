# frozen_string_literal: true

module Marriage
  module Services
    extend ActiveSupport::Concern

    def mandrill_service
      Mandrill::Service.instance
    end
  end
end

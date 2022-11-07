# frozen_string_literal: true

module Mandrill
  class Request
    class Welcome < Mandrill::Request::Base
      TEMPLATE_KEY = 'welcome'
    end
  end
end

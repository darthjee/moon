# frozen_string_literal: true

module Moon
  class Exception < StandardError
    class LoginFailed < Moon::Exception; end
  end
end

# frozen_string_literal: true

class Mandrill::Message::Access < Mandrill::Message::Base
  private

  def data_json
    super.merge(
      token: user.authentication_token
    )
  end
end

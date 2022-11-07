# frozen_string_literal: true

class Mandrill::Message::Password < Mandrill::Message::Access
  private

  def data_json
    super.merge(
      code: user.code
    )
  end
end

class Mandrill::Message::Password < Mandrill::Message::Base

  private

  def data_json
    super.merge(
      code: user.code,
      token: user.authentication_token
    )
  end
end

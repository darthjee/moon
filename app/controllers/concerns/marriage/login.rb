module Marriage::Login
  extend ActiveSupport::Concern
  include Marriage::Common

  private

  def is_logged?
    invite_from_credential.present?
  end

  def credential
    @credential ||= cookies.signed[:credentials]
  end

  def invite_from_credential
    return unless credential.present?
    @invite_from_credential ||= find_invite_from_credential
  end

  def find_invite_from_credential
    marriage.invites.find_by(authentication_token: credential)
  end
end
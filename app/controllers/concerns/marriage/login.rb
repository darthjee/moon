module Marriage::Login
  extend ActiveSupport::Concern
  include Marriage::Common

  private

  def is_logged?
    invite_from_credential.present?
  rescue ActiveRecord::RecordNotFound
    false
  end

  def credential
    @credential ||= cookies.signed[:credentials]
  end

  def invite_from_credential
    @invite_from_credential ||= find_invite_from_credential
  end

  def find_invite_from_credential
    marriage.invites.where.not(authentication_token: nil).find_by!(authentication_token: credential)
  end
end
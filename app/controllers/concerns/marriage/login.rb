module Marriage::Login
  extend ActiveSupport::Concern
  include Marriage::Common

  included do
    before_action :login_from_parameters
  end

  def sign_in(user)
    cookies.signed[:credentials] = user.authentication_token
  end

  private

  def login_from_parameters
    sign_in(user_from_from_parameters) if token_parameter
  end

  def user_from_from_parameters
    marriage.invites.find_by(authentication_token: token_parameter)
  end

  def is_logged?
    logged_user.present?
  end

  def logged_user
    invite_from_credential
  rescue ActiveRecord::RecordNotFound
    nil
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

  def token_parameter
    params[:token]
  end
end

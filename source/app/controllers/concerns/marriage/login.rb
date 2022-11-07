# frozen_string_literal: true

module Marriage::Login
  extend ActiveSupport::Concern

  included do
    before_action :login_from_parameters
  end

  def sign_in(user)
    cookies.signed[:credentials] = user.authentication_token
  end

  def sign_off
    cookies.delete(:credentials)
  end

  private

  def login_from_parameters
    sign_in(user_from_from_parameters) if token_parameter
  end

  def user_from_from_parameters
    User.find_by(authentication_token: token_parameter)
  end

  def logged?
    logged_user.present?
  end

  def logged_user
    user_from_credential
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def credential
    @credential ||= cookies.signed[:credentials]
  end

  def user_from_credential
    @user_from_credential ||= find_user_from_credential
  end

  def invite_from_credential
    user_from_credential.try(:invite)
  end

  def find_user_from_credential
    User.where.not(authentication_token: nil).find_by!(authentication_token: credential)
  end

  def token_parameter
    params[:token]
  end
end

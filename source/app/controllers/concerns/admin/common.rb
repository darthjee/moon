# frozen_string_literal: true

module Admin::Common
  extend ActiveSupport::Concern
  include ::Marriage::Common
  include Tarquinn

  included do
    redirection_rule :forbidden_path, :lack_admin?
    skip_redirection_rule :forbidden_path, :is_html?, :is_home?
  end

  def forbidden_path
    forbidden_admin_login_index_path
  end

  def admin_key
    ENV['ADMIN_KEY']
  end

  def lack_admin?
    !is_admin?
  end

  def admin_key_from_request
    params[:admin_key]
  end

  def admin_key_from_cookies
    cookies.signed[:admin_key]
  end

  def admin_keys
    [admin_key_from_cookies, admin_key_from_request]
  end

  def is_admin?
    if admin_keys.include? admin_key
      cookies.signed[:admin_key] = admin_key
      true
    else
      cookies.delete(:admin_key)
      false
    end
  end
end

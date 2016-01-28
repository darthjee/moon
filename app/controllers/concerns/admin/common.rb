module Admin::Common
  extend ActiveSupport::Concern
  include Tarquinn

  included do
    redirection_rule :forbidden_path, :lack_admin?
  end

  def forbidden_path
    forbidden_admin_login_index_path
  end

  def admin_key
    ENV['ADMIN_KEY']
  end

  def lack_admin?
    ! is_admin?
  end

  def admin_key_from_request
    params[:admin_key]
  end

  def admin_key_from_cookies
    cookies.signed[:admin_key] ||= admin_key_from_request
  end

  def is_admin?
    admin_key_from_cookies == admin_key
  end
end
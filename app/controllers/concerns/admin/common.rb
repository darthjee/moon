module Admin::Common
  extend ActiveSupport::Concern

  def admin_key
    ENV['ADMIN_KEY']
  end

  def require_admin
    head :forbidden unless is_admin?
  end

  def is_admin?
    params[:admin_key] == admin_key
  end
end